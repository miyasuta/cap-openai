const cds = require('@sap/cds');
const OpenAI = require("openai");

module.exports = class ChatService extends cds.ApplicationService {
    async init () {
        this.on('chat_sdk', async(req) => {
            const apiKey = process.env['OPENAI_API_KEY'];
            console.log(apiKey);
            const request = req.data.input;
            const openai = new OpenAI({
                apiKey: apiKey //省略可能
            });

            const response = await openai.chat.completions.create({
                messages: [
                    { role: "system", content: "You are a helpful assistant." },
                    { role: "user", content: request }
                ],
                model: "gpt-3.5-turbo",
              });

            console.log(response);
            return response.choices[0].message.content;

        })

        this.on('chat_api', async(req) => {
            const apiKey = process.env['OPENAI_API_KEY'];
            console.log(apiKey);
            const request = req.data.input;
            const openai = await cds.connect.to('OpenAI.Chat.Completion.API');
            const data = {
                "model": "gpt-3.5-turbo",
                "messages": [
                    { role: "system", content: "You are a helpful assistant." },
                    { role: "user", content: request }
                ]
            };
            const response = await openai.send({
                method: 'POST',
                path: '/chat/completions',
                headers: {
                    "Authorization": "Bearer " + apiKey,
                    "Content-Type": "application/json"
                },
                data: data
            });

            console.log(response);
            return response.choices[0].message.content;
        })
        return super.init();
    }
}