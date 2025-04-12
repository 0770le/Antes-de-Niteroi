#macro OPTIONS_FULLSCREEN				"fullscreen"
#macro OPTIONS_MASTER_ENABLED			"master_enabled"
#macro OPTIONS_MASTER_VOLUME			"master_volume"
#macro OPTIONS_MUSIC_ENABLED			"music_enabled"
#macro OPTIONS_MUSIC_VOLUME				"music_volume"
#macro OPTIONS_SFX_ENABLED				"sfx_enabled"
#macro OPTIONS_SFX_VOLUME				"sfx_volume"
#macro OPTIONS_MUSIC_PARAMETER          "music_parameter"
#macro OPTIONS_DEAF_ASSISTANCE          "deaf_assistance"

#macro OPTIONS_GAMEPAD_KEYMAP			"gamepad_keymap"
#macro OPTIONS_KEYBOARD_KEYMAP			"keyboard_keymap"
#macro OPTIONS_LAST_INPUT_SOURCE_TYPE	"last_input_source_type"

#macro OPTIONS_IS_NEW_GAME				"is_new_game"
#macro OPTIONS_LAST_ROOM				"last_room"
#macro OPTIONS_SPAWN_X					"spawn_x"
#macro OPTIONS_SPAWN_Y					"spawn_y"
#macro OPTIONS_PLAYER_LIVES				"player_lives"
#macro OPTIONS_PLAYER_HP				"player_hp"
#macro OPTIONS_PLAYER_DIED				"player_died"
#macro OPTIONS_PLAYER_HAS_BOW			"player_has_bow"
#macro OPTIONS_PLAYER_HAS_CAPE			"player_has_cape"
#macro OPTIONS_PLAYER_ARROWS			"player_arrows"
#macro OPTIONS_PLAYER_FACING			"player_facing"

#macro OPTIONS_HP_UPGRADES				"hp_upgrades"
#macro OPTIONS_ARROW_UPGRADES			"arrow_upgrades"
#macro OPTIONS_SOUND_STAGES				"sound_stages"

// saveables

options = new OptionsModel();

new_game_properties = [
	OPTIONS_LAST_ROOM, OPTIONS_SPAWN_X, OPTIONS_SPAWN_Y, 
	OPTIONS_PLAYER_LIVES, OPTIONS_PLAYER_HP, OPTIONS_PLAYER_DIED, OPTIONS_PLAYER_HAS_BOW, 
	OPTIONS_PLAYER_HAS_CAPE, OPTIONS_PLAYER_ARROWS, OPTIONS_PLAYER_FACING, OPTIONS_MUSIC_PARAMETER,
	OPTIONS_HP_UPGRADES, OPTIONS_ARROW_UPGRADES, OPTIONS_SOUND_STAGES
]

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
		_listeners[_i].on_options_change(options); 
	}
}

function clear_game_data()
{
	var _new_game_options = new OptionsModel();
	
	for (var _i = 0; _i < array_length(new_game_properties); _i++) {
		options[$ new_game_properties[_i]] = _new_game_options[$ new_game_properties[_i]];
	}
	
	save_and_notify();
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
		
		global.game.has_bow = options.player_has_bow;
		global.game.has_cape = options.player_has_cape;
		global.game.has_cloak = options.player_has_cape;
		
		global.game.max_hp = global.game.max_hp_initial + array_length(options.hp_upgrades);
		global.game.max_arrows = global.game.max_arrows_initial + (array_length(options.arrow_upgrades)*10);
		
	} catch (_e) {
		
		global.logger.error($"failed to load options file in room {room}: {_e}");
		
		options = new OptionsModel();
		
		global.input_manager.gamepad_keymap = options.gamepad_keymap;
		global.input_manager.keyboard_keymap = options.keyboard_keymap;
		global.input_manager.last_input_source_type = options.last_input_source_type;
		
		global.game.has_bow = options.player_has_bow;
		global.game.has_cape = options.player_has_cape;
		global.game.has_cloak = options.player_has_cape;
		
		
		global.game.max_hp = global.game.max_hp_initial;
		
		write_all();
	}
}

#endregion

function add_to_array(_option = OPTIONS_HP_UPGRADES, _value = max_hp_location.UPGRADE_AKARAY_1)
{
	if(!array_contains(options[$ _option], _value)){
		array_push(options[$ _option], _value);	
		save_and_notify();
	}
}

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

function get_sound_stage(
	_sound_stage = SOUND_STAGE_GENERAL)
{
	return options.sound_stages[$ _sound_stage];
}

function set_sound_stage(
	_sound_stage = SOUND_STAGE_GENERAL, 
	_event = FMOD_EVENT.MUSIC_GAMEPLAY_01, 
	_parameter_name = FMOD_PARAMETER_NAME_MUSIC,
	_parameter_value = FMOD_PARAMETER_MUSIC_STAGE_GENERAL_VALUE.INTRO)
{
	options.sound_stages[$ _sound_stage].event = _event;
	options.sound_stages[$ _sound_stage].parameter_name = _parameter_name;
	options.sound_stages[$ _sound_stage].parameter_value = _parameter_value;
	
	save_and_notify();
}

function set_sound_stage_event(
	_sound_stage = SOUND_STAGE_GENERAL, 
	_event = FMOD_EVENT.MUSIC_GAMEPLAY_01)
{
	options.sound_stages[$ _sound_stage].event = _event;
	
	save_and_notify();
}

function set_sound_stage_parameter(
	_sound_stage = SOUND_STAGE_GENERAL, 
	_parameter_value = FMOD_PARAMETER_MUSIC_STAGE_GENERAL_VALUE.INTRO)
{
	options.sound_stages[$ _sound_stage].parameter_value = _parameter_value;
	
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