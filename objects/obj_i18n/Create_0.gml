global.i18n = self;

enum LANGUAGES 
{
	UNSET, PT_BR, EN_US
}

enable              = false;
language_default	= LANGUAGES.PT_BR;
language			= language_default;
messages			= {};
messages_default	= {};

#region public

function get_message(_message_key = "hello-world", _parameters = undefined)
{
	var _message = "";
	
	// retrieve message
	
	if (variable_struct_exists(messages, _message_key))
	{
		_message = messages[$ _message_key];
	}
	else if (variable_struct_exists(messages_default, _message_key))
	{
		global.logger.warn($"i18n: message {_message_key} not found for {get_os_language_as_string(language)}; returned default language {get_os_language_as_string(language_default)}")		
		
		_message = messages_default[$ _message_key];
	}
	else 
	{
		global.logger.warn(
			$"i18n: message {_message_key} not found for {get_os_language_as_string(language)} nor the default language {get_os_language_as_string(language_default)}; returned error message"
		);		
		
		return _message_key;
	}
	
	// fill parameters
	
	if (_parameters != undefined)
	{
		var _keys = struct_get_names(_parameters);
		
		for (var _i = 0; _i < array_length(_keys); _i++)
		{
			var _key = _keys[_i];
			
			_message = string_replace(_message, $"$\{{_key}\}", _parameters[$ _key]);
		}

	}
	
	return _message;
}

function change_language(_language = LANGUAGES.PT_BR)
{
	if (_language != language)
	{
		language = _language;
	
		messages = language != language_default
			? get_messages(language)
			: messages_default;	
	}
}

function get_next_language()
{
	switch (language)
	{
		case LANGUAGES.PT_BR:
			return LANGUAGES.EN_US;
		case LANGUAGES.EN_US:
		case LANGUAGES.UNSET:
			return LANGUAGES.PT_BR;
		default: 
			global.logger.error("i18n language not found; falling back to PT_BR");
			
			return LANGUAGES.PT_BR;
	}
}

#endregion

#region private

function get_os_language()
{
	// reference: 
	// https://manual.gamemaker.io/monthly/en/#t=GameMaker_Language%2FGML_Reference%2FOS_And_Compiler%2Fos_get_language.htm
	switch (os_get_language())
	{
		case "pt": 
			return LANGUAGES.PT_BR;
		case "en":
			return LANGUAGES.EN_US;
		default: 
			return language_default;
	}
}

function get_os_language_as_string(_language = LANGUAGES.PT_BR)
{
	switch (_language)
	{
		case LANGUAGES.PT_BR:
			return "pt-BR";
		case LANGUAGES.EN_US:
			return "en-US";
		default:
			global.logger.error($"i18n: language not mapped {_language}");
			
			return get_os_language_as_string(language_default);
	}
}

function json_to_string(_filename = "") 
{
	if (file_exists(_filename)) 
	{
	    var _file_to_read = file_text_open_read(_filename);
	    var _json_string = "";

		while (!file_text_eof(_file_to_read))
		{
	        var _string_to_read = file_text_read_string(_file_to_read);
		
			if (string_pos("//", _string_to_read) == 0) 
			{
				_json_string += _string_to_read;
			} 
			else 
			{
				show_debug_message(string_pos("/", _string_to_read));
			}
			
			file_text_readln(_file_to_read);
	    }
		
	    file_text_close(_file_to_read);
	
	    return _json_string;
	}
}

function get_messages(_language = LANGUAGES.PT_BR)
{
	var _messages_file_path = $"{working_directory}messages\\messages-{get_os_language_as_string(_language)}.json";
	
	var _messages_file_content = json_to_string(_messages_file_path);
	
	return json_parse(_messages_file_content);
}

function init()
{
	language = enable ? global.options_controller.get_option(OPTIONS_LANGUAGE) : language_default;
	
	if (enable && language == LANGUAGES.UNSET)
	{
		language = enable ? get_os_language() : language_default;
		
		global.options_controller.set_option(OPTIONS_LANGUAGE, language);
	}
	
	messages_default = get_messages(language_default);	
	
	messages = language != language_default
		? get_messages(language)
		: messages_default;
}

#endregion

init();
