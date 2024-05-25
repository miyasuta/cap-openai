/* checksum : 8eef0921fa9886f5a9fe14fc48083c9d */
@Capabilities.BatchSupported : false
@Capabilities.KeyAsSegmentSupported : true
@Core.Description : 'OpenAI Chat Completion API'
@Core.SchemaVersion : '1.0.0'
@Core.LongDescription : 'API for creating chat completions using OpenAI''s language models.'
service OpenAI.Chat.Completion.API {};

@Core.Description : 'Create Chat Completion'
@Core.LongDescription : 'Creates a completion for the provided chat message.'
@openapi.path : '/chat/completions'
action OpenAI.Chat.Completion.API.chat_completions_post(
  @openapi.in : 'body'
  body : {
    @description : 'The ID of the model to use.'
    @Core.Example.$Type : 'Core.PrimitiveExampleValue'
    @Core.Example.Value : 'gpt-3.5-turbo'
    model : String;
    @description : 'A list of messages comprising the conversation.'
    messages : many {
      @description : 'The role of the author of this message.'
      @assert.range : true
      role : String enum {
        system;
        user;
        assistant;
      };
      @description : 'The content of the message.'
      content : String;
    };
    @description : 'The maximum number of tokens to generate in the completion.'
    max_tokens : Integer;
    @description : 'Sampling temperature to use.'
    temperature : Decimal default 1;
    @description : 'Nucleus sampling probability.'
    top_p : Decimal default 1;
    @description : 'How many completions to generate for each prompt.'
    n : Integer default 1;
    @description : 'Whether to stream back partial progress.'
    stream : Boolean default false;
    @description : 'Up to 4 sequences where the API will stop generating further tokens.'
    @JSON.Schema : '{"type":["array","string"],"items":{"type":"string"}}'
    stop : common.JSON;
    @description : 'Penalty for presence of existing tokens.'
    presence_penalty : Decimal default 0;
    @description : 'Penalty for frequency of existing tokens.'
    frequency_penalty : Decimal default 0;
    @description : 'Modifies the likelihood of specified tokens appearing in the completion.'
    logit_bias : { };
    @description : 'A unique identifier representing the end-user.'
    user : String;
  }
) returns {
  @description : 'The ID of the completion.'
  id : String;
  @description : 'The object type, usually ''chat.completion''.'
  object : String;
  @description : 'Creation time in epoch seconds.'
  created : Integer;
  @description : 'The model used.'
  model : String;
  choices : many {
    message : {
      role : String;
      content : String;
    };
    finish_reason : String;
    index : Integer;
  };
  usage : {
    prompt_tokens : Integer;
    completion_tokens : Integer;
    total_tokens : Integer;
  };
};

type common.JSON : LargeString;

