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
		music_parameter: FMOD_PARAMETER_MUSIC_STAGE_GENERAL_VALUE.INTRO,
		deaf_assistance: false,
		language: LANGUAGES.UNSET,
		
		unlocked_catalog_items: [],
		checked_catalog_items: [],
		last_input_source_type: INPUT_SOURCE_TYPE.GAMEPAD,
		
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
		
		is_new_game: true,
		last_room: int64(rm_cidade_velha),
		spawn_x: 0,
		spawn_y: 0,
		player_lives: 3,
		player_hp: 10,
		player_died: false,		
		player_has_bow: false,
		player_has_cape: false,
		player_arrows: 0,
		player_facing: 1,
		
		quest_saved_kunumiuasu: false,
		quest_saved_kunumiuasu_seregipe: false,
		quest_saved_kunumiuasu_morguja: false,
		quest_step_portugues: 0,
		
		hp_upgrades: [],
		arrow_upgrades: [],
		
		sound_stages: new SoundStagesModel([
			new SoundStageModel(
				SOUND_STAGE_MAIN_MENU,
				FMOD_EVENT.MUSIC_MAIN_MENU,
				"",
				0
			),
			new SoundStageModel(
				SOUND_STAGE_GENERAL,
				FMOD_EVENT.MUSIC_GAMEPLAY_01,
				FMOD_PARAMETER_NAME_MUSIC,
				FMOD_PARAMETER_MUSIC_STAGE_GENERAL_VALUE.INTRO
			),
			new SoundStageModel(
				SOUND_STAGE_SEREGIPE,
				FMOD_EVENT.MUSIC_SEREGIPE,
				FMOD_PARAMETER_NAME_MUSIC,
				FMOD_PARAMETER_MUSIC_STAGE_SEREGIPE_VALUE.INTRO
			),
			new SoundStageModel(
				SOUND_STAGE_SEREGIPE_2,
				FMOD_EVENT.MUSIC_SEREGIPE_2,
				FMOD_PARAMETER_NAME_MUSIC,
				FMOD_PARAMETER_MUSIC_STAGE_SEREGIPE_2_VALUE.INTRO
			),
			new SoundStageModel(
				SOUND_STAGE_RERIPE,
				FMOD_EVENT.MUSIC_RERIPE,
				FMOD_PARAMETER_NAME_MUSIC,
				FMOD_PARAMETER_MUSIC_STAGE_RERIPE_VALUE.INTRO
			),
			new SoundStageModel(
				SOUND_STAGE_CREDITS,
				FMOD_EVENT.MUSIC_CREDITS,
				"",
				0
			)
		])
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
	music_parameter = _options_model.music_parameter;
	deaf_assistance = _options_model.deaf_assistance;
	language = _options_model.language;
	
	// catalog items
	unlocked_catalog_items = _options_model.unlocked_catalog_items;
	checked_catalog_items = _options_model.checked_catalog_items;
	
	// keymaps 
	gamepad_keymap = _options_model.gamepad_keymap;
	keyboard_keymap = _options_model.keyboard_keymap;
	last_input_source_type = _options_model.last_input_source_type;
	
	// position progress
	is_new_game = _options_model.is_new_game;
	last_room = _options_model.last_room;
	spawn_x = _options_model.spawn_x;
	spawn_y = _options_model.spawn_y;
	player_lives = _options_model.player_lives;
	player_hp = _options_model.player_hp;
	player_died = _options_model.player_died;
	player_has_bow = _options_model.player_has_bow;
	player_has_cape = _options_model.player_has_cape;
	player_arrows = _options_model.player_arrows;
	player_facing = _options_model.player_facing;
	
	// quest progress
	
	quest_saved_kunumiuasu = _options_model.quest_saved_kunumiuasu;
	quest_saved_kunumiuasu_seregipe = _options_model.quest_saved_kunumiuasu_seregipe;
	quest_saved_kunumiuasu_morguja = _options_model.quest_saved_kunumiuasu_morguja;
	quest_step_portugues = _options_model.quest_step_portugues;
	
	//game upgrades
	hp_upgrades = _options_model.hp_upgrades;
	arrow_upgrades = _options_model.arrow_upgrades;
	
	//sounds
	sound_stages = _options_model.sound_stages;
}
