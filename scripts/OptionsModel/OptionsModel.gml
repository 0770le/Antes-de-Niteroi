function OptionsModel (
	_options_model = 
	{
		fullscreen: false,
		master_enabled: true,
		master_volume: 10,
		music_enabled: true,
		music_volume: 10,
		sfx_enabled: true,
		sfx_volume: 10,
		
		unlocked_catalog_items: [],
		checked_catalog_items: [],
		
		gamepad_keymap: 
		[
			gp_face1,
			gp_face2,
			gp_face3,
			gp_face4,
			gp_shoulderr
		],
		keyboard_keymap: 
		[
			vk_space,
			ord("F"),
			ord("S"),
			ord("D"),
			ord("E"),
			vk_up,
			vk_left,
			vk_down,
			vk_right,
		],
		
		last_room: rm_cidade_velha,
		last_player_x: 0,
		last_player_y: 0
	}) 
constructor 
{
	// video
	fullscreen = _options_model.fullscreen;
	
	// sound
	master_enabled = _options_model.master_enabled;
	master_volume = _options_model.master_volume;
	music_enabled = _options_model.music_enabled;
	music_volume = _options_model.music_volume;
	sfx_enabled = _options_model.sfx_enabled;
	sfx_volume = _options_model.sfx_volume;
	
	// catalog items
	unlocked_catalog_items = _options_model.unlocked_catalog_items;
	checked_catalog_items = _options_model.checked_catalog_items;
	
	// keymaps 
	gamepad_keymap = _options_model.gamepad_keymap;
	keyboard_keymap = _options_model.keyboard_keymap;
	
	// game progress
	last_room = _options_model.last_room;
	last_player_x = _options_model.last_player_x;
	last_player_y = _options_model.last_player_y;
}