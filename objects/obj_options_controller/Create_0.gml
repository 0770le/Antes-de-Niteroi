#macro OPTIONS_FULLSCREEN				"fullscreen"
#macro OPTIONS_MASTER_ENABLED			"master_enabled"
#macro OPTIONS_MASTER_VOLUME			"master_volume"
#macro OPTIONS_MUSIC_ENABLED			"music_enabled"
#macro OPTIONS_MUSIC_VOLUME				"music_volume"
#macro OPTIONS_SFX_ENABLED				"sfx_enabled"
#macro OPTIONS_SFX_VOLUME				"sfx_volume"

#macro OPTIONS_GAMEPAD_KEYMAP			"gamepad_keymap"
#macro OPTIONS_KEYBOARD_KEYMAP			"keyboard_keymap"
#macro OPTIONS_LAST_INPUT_SOURCE_TYPE	"last_input_source_type"

#macro OPTIONS_IS_NEW_GAME				"is_new_game"
#macro OPTIONS_LAST_ROOM				"last_room"
#macro OPTIONS_SPAWN_X					"spawn_x"
#macro OPTIONS_SPAWN_Y					"spawn_y"
#macro OPTIONS_PLAYER_LIVES				"player_lives"
#macro OPTIONS_PLAYER_HP				"player_hp"

// saveables

options = new OptionsModel();

// transients

listeners	= ds_map_create();
savefile	= "options.rec";

#region events

function register_listener(_listener = noone)
{
	listeners[? _listener.id] = _listener;
}

function unregister_listener(_listener = noone)
{
	ds_map_delete(listeners, _listener.id);
}

function notify_listeners() 
{
    var _listeners = ds_map_values_to_array(listeners, []);
	
	for (var _i = 0; _i < array_length(_listeners); _i++)
	{
		_listeners[_i].on_options_change(self.options); 
	}
}

#endregion

#region persistance

function write_all()
{
	global.logger.debug("writing save file");
	
	try
	{
		var _json = json_stringify(options);
	
		var _savefile = file_text_open_write(savefile);
	
		file_text_write_string(_savefile, _json);
	
		file_text_close(_savefile);
	}
	catch (_e)
	{
		global.logger.error($"writing options file {_e}");	
	}
}

function get_merged_options(_persisted_options = {})
{
	var _new_options = new OptionsModel();
	
	var _keys = variable_struct_get_names(_new_options);
	
	for (var _i = 0; _i < array_length(_keys); _i++)
	{
		if (variable_struct_exists(_persisted_options, _keys[_i])) 
		{
			_new_options[$ _keys[_i]] = _persisted_options[$ _keys[_i]];
		}
	}
	
	return _new_options;
}

function read_all()
{
	global.logger.debug($"reading log file {filename_path(savefile)}{savefile}");
	
	try {
		
		var _savefile = file_text_open_read(savefile);
	
		var _json = file_text_read_string(_savefile);
	
		var _options_model = json_parse(_json);
	
		options = get_merged_options(_options_model);	
		
		file_text_close(_savefile);
		
		global.input_manager.gamepad_keymap = options.gamepad_keymap;
		global.input_manager.keyboard_keymap = options.keyboard_keymap;
		global.input_manager.last_input_source_type = options.last_input_source_type;
	} catch (_e) {
		
		global.logger.error($"failed to load options file in room {room}: {_e}");
		
		options = new OptionsModel();
		
		global.input_manager.gamepad_keymap = options.gamepad_keymap;
		global.input_manager.keyboard_keymap = options.keyboard_keymap;
		global.input_manager.last_input_source_type = options.last_input_source_type;
		
		write_all();
	}
}

#endregion

function save_and_notify()
{
	write_all();
	
	notify_listeners();
}

function get_option(_option_macro = OPTIONS_FULLSCREEN)
{
	return options[$ _option_macro];
}

function set_options(_options = {})
{
	var _keys = variable_struct_get_names(_options);
	
	for (var _i = 0; _i < array_length(_keys); _i++)
	{
		var _key = _keys[_i];
		
		options[$ _key] = _options[$ _key];
	}
	
	save_and_notify();
}

function set_option(_option_macro = OPTIONS_FULLSCREEN, _new_value = 0)
{
	options[$ _option_macro] = _new_value;
	
	save_and_notify();
}

function add_unlocked_item(_catalog_item_type = CATALOG_ITEM_TYPE.ARARIBOIA)
{
	if (!array_contains(options.unlocked_catalog_items, _catalog_item_type))
	{	
		array_push(options.unlocked_catalog_items, _catalog_item_type);
	
		write_all();
	}
}

function add_checked_item(_catalog_item_type = CATALOG_ITEM_TYPE.ARARIBOIA)
{
	if (!array_contains(options.checked_catalog_items, _catalog_item_type))
	{	
		array_push(options.checked_catalog_items, _catalog_item_type);
	
		write_all();
	}
}

function clear_unlocks()
{
	array_delete(options.unlocked_catalog_items, 0, array_length(options.unlocked_catalog_items))
	array_delete(options.checked_catalog_items, 0, array_length(options.checked_catalog_items))
	
	write_all();
}

function register_listeners()
{
	with(o_camera) other.register_listener(self);
	with(o_sound_controller) other.register_listener(self);
}

function init()
{
	global.options_controller = self;
	
	register_listeners();
	
	if (file_exists(savefile))
	{
		read_all();
	}
	else 
	{
		write_all();
	}
	
	notify_listeners();
}

init();