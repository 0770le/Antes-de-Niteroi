global.sound_controller = self;

fmod										= noone;
master_bank_index							= noone;
master_strings_bank_index					= noone;
event_per_enum								= ds_map_create();
vcas_per_enum								= ds_map_create();
busses_per_enum								= ds_map_create();
											
music_enabled								= true;
sfx_enabled									= true;
music_volume								= 100;
sfx_volume									= 100;
											
fmod_3d_att									= undefined;
music_parameter								= FMOD_PARAMETER_MUSIC_STAGE_GENERAL_VALUE.INTRO;
is_playing_music							= false;
deaf_assistance								= false;

current_room								= undefined;

ambience_sounds_by_room						= ds_map_create();
ambience_sounds_by_room[? rm_cidade_velha]	= FMOD_EVENT.AMBIENCE_CIDADE_VELHA;
ambience_sounds_by_room[? rm_akaray]		= FMOD_EVENT.AMBIENCE_AKARAY;
ambience_sounds_by_room[? rm_keryi]			= FMOD_EVENT.AMBIENCE_KERYL;
ambience_sounds_by_room[? rm_morguja_uasu]	= FMOD_EVENT.AMBIENCE_MORGUJA;
ambience_sounds_by_room[? rm_seregipe]		= FMOD_EVENT.AMBIENCE_SEREGIPE;

current_sound_stage_name					= undefined;

function on_camera_update(_x, _y) 
{
	global.logger.trace($"on_camera_update: listener position updated x: {_x}, y: {_y}"); 
	
	fmod_3d_att.position.x = _x;
	fmod_3d_att.position.y = _y;
	
	fmod_3d_att.forward.z = -1;
 	fmod_3d_att.up.y = -1;

	fmod_studio_system_set_listener_attributes(0, fmod_3d_att);
	
	update_ambience_sound_positions(_x, _y);
}

function update_ambience_sound_positions(_x = 0, _y = 0)
{
	if (is_undefined(global.sound_controller.current_room)) return;
	
	var _fmod_events = ds_map_values_to_array(ambience_sounds_by_room, []); 
	
	for (var _i = 0; _i < array_length(_fmod_events); _i++)
	{
		update_event_position(_fmod_events[_i], _x, _y);
	}
}

function stop_ambience_sounds()
{
	array_foreach(
		ds_map_values_to_array(ambience_sounds_by_room, []), 
		function (_fmod_event) {
			global.sound_controller.stop(_fmod_event);
	});
}

function start_ambience_sounds_with_room(_room = rm_cidade_velha) 
{
	if (array_contains(ds_map_keys_to_array(ambience_sounds_by_room, []), _room))
	{
		global.sound_controller.play(ambience_sounds_by_room[? _room]);
		global.sound_controller.current_room = _room;
	} 
	else 
	{
		global.sound_controller.current_room = undefined;
	}
}

function update_sound_stage(_room = rm_cidade_velha) 
{
	var _new_sound_stage_name = get_sound_stage(_room);
	
	// skips if already on the right stage
	if (current_sound_stage_name == _new_sound_stage_name) return;
	
	// stops the music if the stage changes
	if (current_sound_stage_name != undefined) 
	{
		var _current_sound_stage = global.options_controller.get_sound_stage(current_sound_stage_name);
		
		stop(_current_sound_stage.event);
	}	
	
	// plays the music if the stage changes
	if (_new_sound_stage_name != undefined)
	{
		var _new_sound_stage = global.options_controller.get_sound_stage(_new_sound_stage_name);
		
		if (_new_sound_stage.parameter_name == "")
		{
			play(_new_sound_stage.event);
		}
		else 
		{
			update_event_parameter_and_play(
				_new_sound_stage.event,
				_new_sound_stage.parameter_name,
				_new_sound_stage.parameter_value,
			);
		}
	}
	
	// updates the current stage reference
	current_sound_stage_name = _new_sound_stage_name;
}

function get_sound_stage(_room = rm_cidade_velha)
{
	switch(_room)
	{
		case rm_main_menu:
			return SOUND_STAGE_MAIN_MENU;
		case rm_seregipe:
			return SOUND_STAGE_SEREGIPE;
		case rm_reri_pe:
			return SOUND_STAGE_RERIPE;
		default: 
			return SOUND_STAGE_GENERAL;
	}
}

function play(_event_enum = FMOD_EVENT.MUSIC_GAMEPLAY_01)
{
	event_per_enum[? _event_enum].play();
}

function stop(_event_enum = FMOD_EVENT.MUSIC_GAMEPLAY_01)
{
	event_per_enum[? _event_enum].stop();
}

function stop_all()
{
	array_foreach(
		ds_map_values_to_array(event_per_enum, []), 
		function (_fmod_event) {
			_fmod_event.stop();
		}
	);
}

function update_event_position(_event_enum = FMOD_EVENT.MUSIC_GAMEPLAY_01, 
								_x = other.x, 
								_y = other.y)
{
	event_per_enum[? _event_enum].update_position(_x, _y);
}

function update_position_and_play(_event_enum = FMOD_EVENT.MUSIC_GAMEPLAY_01, 
								_x = other.x, 
								_y = other.y)
{
	event_per_enum[? _event_enum].update_position(_x, _y);
	event_per_enum[? _event_enum].play();
}

function update_event_parameter(_event_enum = FMOD_EVENT.MUSIC_GAMEPLAY_01, 
								_parameter_name = undefined, 
								_parameter_value = undefined)
{
	event_per_enum[? _event_enum].update_parameter(_parameter_name, _parameter_value);
}

function update_event_parameter_and_play(_event_enum = FMOD_EVENT.MUSIC_GAMEPLAY_01, 
										 _parameter_name = undefined, 
										 _parameter_value = undefined)
{
	event_per_enum[? _event_enum].update_parameter(_parameter_name, _parameter_value);
	event_per_enum[? _event_enum].play();
}

function update_event_parameter_and_play_pos(_event_enum = FMOD_EVENT.MUSIC_GAMEPLAY_01, 
										 _parameter_name = undefined, 
										 _parameter_value = undefined,
										 _x = 0,
										 _y = 0)
{
	event_per_enum[? _event_enum].update_parameter(_parameter_name, _parameter_value);
	event_per_enum[? _event_enum].update_position(_x, _y);
	event_per_enum[? _event_enum].play();
}

function load_fmod()
{
	fmod = instance_create_depth(0, 0, 0, o_fmod);
	
	master_bank_index = fmod_studio_system_load_bank_file(fmod_path_bundle("sounds/Master.bank"), FMOD_STUDIO_LOAD_BANK.NORMAL);
	
	master_strings_bank_index = fmod_studio_system_load_bank_file(fmod_path_bundle("sounds/Master.strings.bank"), FMOD_STUDIO_LOAD_BANK.NORMAL);
}

function load_events()
{
	#region musics
	
	event_per_enum[? FMOD_EVENT.MUSIC_MAIN_MENU] = new FmodEvent(
		"event:/MUSIC/mus_menu", [ ]);
	
	event_per_enum[? FMOD_EVENT.MUSIC_GAMEPLAY_01] = new FmodEvent(
		"event:/MUSIC/mus_gameplay_01", 
		[
			new FmodParameter(
				FMOD_PARAMETER_NAME_MUSIC, 
				[
					FMOD_PARAMETER_MUSIC_STAGE_GENERAL_VALUE.INTRO,
					FMOD_PARAMETER_MUSIC_STAGE_GENERAL_VALUE.ENGAGE_FIRST_ENEMY,
					FMOD_PARAMETER_MUSIC_STAGE_GENERAL_VALUE.SIDE_ROOMS,
				])
		]);
		
	event_per_enum[? FMOD_EVENT.MUSIC_GAMEPLAY_02] = new FmodEvent(
		"event:/MUSIC/mus_gameplay_02", [ ]);
		
	event_per_enum[? FMOD_EVENT.MUSIC_SEREGIPE] = new FmodEvent(
		"event:/MUSIC/mus_seregipe", 
		[
			new FmodParameter(
				FMOD_PARAMETER_NAME_MUSIC,
				[
					FMOD_PARAMETER_MUSIC_STAGE_SEREGIPE_VALUE.INTRO,
					FMOD_PARAMETER_MUSIC_STAGE_SEREGIPE_VALUE.INSIDE
				])
		]);
		
	event_per_enum[? FMOD_EVENT.MUSIC_RERIPE] = new FmodEvent(
		"event:/MUSIC/mus_reripe",
		[
			new FmodParameter(
				FMOD_PARAMETER_NAME_MUSIC,
				[
					FMOD_PARAMETER_MUSIC_STAGE_RERIPE_VALUE.INTRO,
					FMOD_PARAMETER_MUSIC_STAGE_RERIPE_VALUE.ON_TOP
				])
		]);
		
	event_per_enum[? FMOD_EVENT.MUSIC_CREDITS] = new FmodEvent(
		"event:/MUSIC/mus_credits", [ ]);
	
	#endregion
	
	#region ambience
	
	event_per_enum[? FMOD_EVENT.AMBIENCE_CIDADE_VELHA] = new FmodEvent(
		"event:/SFX/AMBIENCE/ROOM_01_CIDADEVELHA/sfx_amb_room_01_cidadevelha", [
			new FmodParameter(
				FMOD_PARAMETER_NAME_AMBIENCE, [
					FMOD_PARAMETER_VALUE_AMBIENCE_CIDADE_VELHA.FAR,
					FMOD_PARAMETER_VALUE_AMBIENCE_CIDADE_VELHA.NEAR
				]
			)
		]);
		
	event_per_enum[? FMOD_EVENT.AMBIENCE_CIDADE_VELHA_SEA] = new FmodEvent(
		"event:/SFX/AMBIENCE/ROOM_01_CIDADEVELHA/sfx_amb_sea", [ ]);
		
	event_per_enum[? FMOD_EVENT.AMBIENCE_AKARAY] = new FmodEvent(
		"event:/SFX/AMBIENCE/ROOM_02_AKARAY/sfx_amb_room_02_akaray", [ ]);
		
	event_per_enum[? FMOD_EVENT.AMBIENCE_KERYL] = new FmodEvent(
		"event:/SFX/AMBIENCE/ROOM_03_KERYI/sfx_amb_room_03_keryi", [ 
			new FmodParameter(
				FMOD_PARAMETER_NAME_AMBIENCE, [
					FMOD_PARAMETER_VALUE_AMBIENCE_KERYL.NO_RAIN,
					FMOD_PARAMETER_VALUE_AMBIENCE_KERYL.LIGHT_RAIN,
					FMOD_PARAMETER_VALUE_AMBIENCE_KERYL.MEDIUM_RAIN,
					FMOD_PARAMETER_VALUE_AMBIENCE_KERYL.HEAVY_RAIN
				]
			)
		]);
		
	event_per_enum[? FMOD_EVENT.AMBIENCE_MORGUJA] = new FmodEvent(
		"event:/SFX/AMBIENCE/ROOM_04_MORGUJA/sfx_amb_room_04_morguja", [ ]);
	
	event_per_enum[? FMOD_EVENT.AMBIENCE_SEREGIPE] = new FmodEvent(
		"event:/SFX/AMBIENCE/ROOM_05_SEREGIPE/sfx_amb_room_05_seregipe", [ ]);
		
	event_per_enum[? FMOD_EVENT.AMBIENCE_RERIPE] = new FmodEvent(
		"event:/SFX/AMBIENCE/ROOM_06_RERIPE/sfx_amb_room_06_reripe", [ ]);
	
	#endregion
	
	#region ARCHER_TUPI
			
	event_per_enum[? FMOD_EVENT.TUPI_ARCHER_ATTACK] = new FmodEvent(
		"event:/SFX/CHARACTER/ENEMIES/ARCHER_TUPINAMBA/sfx_enem_tupi_archer_atk",
		[ 
			new FmodParameter(
				FMOD_PARAMETER_NAME_MOVE,
				[
					FMOD_PARAMETER_VALUE_TUPI_ARCHER_ATTACK.PREPARE,
					FMOD_PARAMETER_VALUE_TUPI_ARCHER_ATTACK.RELEASE
				])
		]);
			
	event_per_enum[? FMOD_EVENT.TUPI_ARCHER_DIE] = new FmodEvent(
		"event:/SFX/CHARACTER/ENEMIES/ARCHER_TUPINAMBA/sfx_enem_tupi_archer_die", [ ]);
			
	event_per_enum[? FMOD_EVENT.TUPI_ARCHER_HURT] = new FmodEvent(
		"event:/SFX/CHARACTER/ENEMIES/ARCHER_TUPINAMBA/sfx_enem_tupi_archer_hurt", [ ]);
	
	#endregion
	
	#region CHEVALIER
	
	event_per_enum[? FMOD_EVENT.CHEVALIER_ATTACK_SHIELD] = new FmodEvent(
		"event:/SFX/CHARACTER/ENEMIES/CHEVALIER/sfx_enem_chev_atk_shield", [ ]);
	
	event_per_enum[? FMOD_EVENT.CHEVALIER_ATTACK_SPEAR_PIERCE] = new FmodEvent(
		"event:/SFX/CHARACTER/ENEMIES/CHEVALIER/sfx_enem_chev_atk_spear_pierce", [ ]);
	
	event_per_enum[? FMOD_EVENT.CHEVALIER_DEATH] = new FmodEvent(
		"event:/SFX/CHARACTER/ENEMIES/CHEVALIER/sfx_enem_chev_death", [ ]);
	
	event_per_enum[? FMOD_EVENT.CHEVALIER_GUARD] = new FmodEvent(
		"event:/SFX/CHARACTER/ENEMIES/CHEVALIER/sfx_enem_chev_guard", [ ]);
	
	event_per_enum[? FMOD_EVENT.CHEVALIER_HURT] = new FmodEvent(
		"event:/SFX/CHARACTER/ENEMIES/CHEVALIER/sfx_enem_chev_hurt", [ ]);
	
	event_per_enum[? FMOD_EVENT.CHEVALIER_TURN] = new FmodEvent(
		"event:/SFX/CHARACTER/ENEMIES/CHEVALIER/sfx_enem_chev_turn", [ ]);
	
	event_per_enum[? FMOD_EVENT.CHEVALIER_WALK] = new FmodEvent(
		"event:/SFX/CHARACTER/ENEMIES/CHEVALIER/sfx_enem_chev_walk", [ ]);
	
	#endregion
	
	#region HARPIA
	
	event_per_enum[? FMOD_EVENT.HARPIA_ATTACK] = new FmodEvent( 
		"event:/SFX/CHARACTER/ENEMIES/HARPIA/sfx_enem_harpia_atk", [ ]);
		
	event_per_enum[? FMOD_EVENT.HARPIA_DIE] = new FmodEvent(
		"event:/SFX/CHARACTER/ENEMIES/HARPIA/sfx_enem_harpia_die", [ ]);
		
	event_per_enum[? FMOD_EVENT.HARPIA_FLAP] = new FmodEvent(
		"event:/SFX/CHARACTER/ENEMIES/HARPIA/sfx_enem_harpia_flap", [ ]);
		
	event_per_enum[? FMOD_EVENT.HARPIA_HURT] = new FmodEvent(
		"event:/SFX/CHARACTER/ENEMIES/HARPIA/sfx_enem_harpia_hurt", [ ]);
		
	event_per_enum[? FMOD_EVENT.HARPIA_IDLE] = new FmodEvent(
		"event:/SFX/CHARACTER/ENEMIES/HARPIA/sfx_enem_harpia_idle", [ ]);

	#endregion
	
	#region MELEE_TUPI
		
	event_per_enum[? FMOD_EVENT.TUPI_MELEE_ATK] = new FmodEvent(
		"event:/SFX/CHARACTER/ENEMIES/MELEE_TUPINAMBA/sfx_enem_tupi_melee_atk",
		[
			new FmodParameter(
				FMOD_PARAMETER_NAME_MOVE, 
				[
					FMOD_PARAMETER_MOVE_VALUE_TUPI_MELEE_ATK.PREPARE,
					FMOD_PARAMETER_MOVE_VALUE_TUPI_MELEE_ATK.SWING
				])
		]);
			
	event_per_enum[? FMOD_EVENT.TUPI_MELEE_DIE] = new FmodEvent(
		"event:/SFX/CHARACTER/ENEMIES/MELEE_TUPINAMBA/sfx_enem_tupi_melee_die", [ ]);
	
	event_per_enum[? FMOD_EVENT.TUPI_MELEE_HIT_GROUND] = new FmodEvent(
		"event:/SFX/CHARACTER/ENEMIES/MELEE_TUPINAMBA/sfx_enem_tupi_melee_hit_ground", [ ]);
			
	event_per_enum[? FMOD_EVENT.TUPI_MELEE_HURT] = new FmodEvent(
		"event:/SFX/CHARACTER/ENEMIES/MELEE_TUPINAMBA/sfx_enem_tupi_melee_hurt", [ ]);
	
	#endregion	
	
	#region OUNCE
	
	event_per_enum[? FMOD_EVENT.OUNCE_ATTACK] = new FmodEvent( 
		"event:/SFX/CHARACTER/ENEMIES/OUNCE/sfx_enem_ounce_atk", [ ]);
		
	event_per_enum[? FMOD_EVENT.OUNCE_DIE] = new FmodEvent(
		"event:/SFX/CHARACTER/ENEMIES/OUNCE/sfx_enem_ounce_die", [ ]);
		
	event_per_enum[? FMOD_EVENT.OUNCE_HURT] = new FmodEvent(
		"event:/SFX/CHARACTER/ENEMIES/OUNCE/sfx_enem_ounce_hurt", [	]);

	#endregion
	
	#region FRENCH_SHOOTER
	
	event_per_enum[? FMOD_EVENT.FRENCH_SHOOTER_COUCH] = new FmodEvent(
		"event:/SFX/CHARACTER/ENEMIES/SHOOTER_FRENCH/sfx_enem_french_shooter_couch", [ ]);
	
	event_per_enum[? FMOD_EVENT.FRENCH_SHOOTER_DIE] = new FmodEvent(
		"event:/SFX/CHARACTER/ENEMIES/SHOOTER_FRENCH/sfx_enem_french_shooter_die", [ ]);
			
	event_per_enum[? FMOD_EVENT.FRENCH_SHOOTER_HURT] = new FmodEvent(
		"event:/SFX/CHARACTER/ENEMIES/SHOOTER_FRENCH/sfx_enem_french_shooter_hurt", [ ]);
		
	event_per_enum[? FMOD_EVENT.FRENCH_SHOOTER_RELOAD] = new FmodEvent(
		"event:/SFX/CHARACTER/ENEMIES/SHOOTER_FRENCH/sfx_enem_french_shooter_reload", [ ]);
		
	event_per_enum[? FMOD_EVENT.FRENCH_SHOOTER_SHOOT] = new FmodEvent(
		"event:/SFX/CHARACTER/ENEMIES/SHOOTER_FRENCH/sfx_enem_french_shooter_shoot", [ ]);
	
	#endregion
	
	#region JARARACA
			
	event_per_enum[? FMOD_EVENT.SNAKE_DIE] = new FmodEvent(
		"event:/SFX/CHARACTER/ENEMIES/SNAKE/sfx_enem_snake_die", [ ]);
			
	event_per_enum[? FMOD_EVENT.SNAKE_HURT] = new FmodEvent(
		"event:/SFX/CHARACTER/ENEMIES/SNAKE/sfx_enem_snake_hurt", [ ]);
	
	#endregion
	
	#region ARMADEIRA
	
	event_per_enum[? FMOD_EVENT.SPIDER_ATTACK] = new FmodEvent(
		"event:/SFX/CHARACTER/ENEMIES/SPIDER/sfx_enem_spider_atk", [ ]);
	
	event_per_enum[? FMOD_EVENT.SPIDER_DIE] = new FmodEvent(
		"event:/SFX/CHARACTER/ENEMIES/SPIDER/sfx_enem_spider_die", [ ]);
			
	event_per_enum[? FMOD_EVENT.SPIDER_HURT] = new FmodEvent(
		"event:/SFX/CHARACTER/ENEMIES/SPIDER/sfx_enem_spider_hurt", [ ]);
		
	#endregion
	
	#region PLAYER
	
	event_per_enum[? FMOD_EVENT.ATTACK_BOW] = new FmodEvent(
		"event:/SFX/CHARACTER/MAIN_ARARIBOIA/ATTACK_MOVES/sfx_main_atk_bow",
		[
			new FmodParameter(
				FMOD_PARAMETER_NAME_MOVE, 
				[
					FMOD_PARAMETER_ATTACK_BOW_VALUE.PREPARE,
					FMOD_PARAMETER_ATTACK_BOW_VALUE.RELEASE
				]),
		]);
	
	event_per_enum[? FMOD_EVENT.ATTACK_HIT] = new FmodEvent(
		"event:/SFX/CHARACTER/MAIN_ARARIBOIA/ATTACK_MOVES/sfx_main_atk_hit",
		[
			new FmodParameter(
				FMOD_PARAMETER_NAME_MOVE, 
				[
					FMOD_PARAMETER_MOVE_VALUE_ATTACK_HIT.MELEE_HIT,
					FMOD_PARAMETER_MOVE_VALUE_ATTACK_HIT.MELEE_GROUND,
					FMOD_PARAMETER_MOVE_VALUE_ATTACK_HIT.ARROW_GROUND,
					FMOD_PARAMETER_MOVE_VALUE_ATTACK_HIT.ARROW_HIT
				])
		]);
	
	event_per_enum[? FMOD_EVENT.ATTACK_MELEE] = new FmodEvent(
		"event:/SFX/CHARACTER/MAIN_ARARIBOIA/ATTACK_MOVES/sfx_main_atk_melee",
		[
			new FmodParameter(
				FMOD_PARAMETER_NAME_MOVE, 
				[
					FMOD_PARAMETER_MOVE_VALUE_MELEE_ATTACK.GROUND_PREPARE,
					FMOD_PARAMETER_MOVE_VALUE_MELEE_ATTACK.GROUND,
					FMOD_PARAMETER_MOVE_VALUE_MELEE_ATTACK.MOVING,
					FMOD_PARAMETER_MOVE_VALUE_MELEE_ATTACK.AIR
				])
		]);
		
	event_per_enum[? FMOD_EVENT.DIE] = new FmodEvent(
		"event:/SFX/CHARACTER/MAIN_ARARIBOIA/BASIC_MOVES/sfx_main_die", [ ]);
		
	event_per_enum[? FMOD_EVENT.EVADE] = new FmodEvent(
		"event:/SFX/CHARACTER/MAIN_ARARIBOIA/BASIC_MOVES/sfx_main_evade",
		[
			new FmodParameter(
				FMOD_PARAMETER_NAME_MOVE, 
				[
					FMOD_PARAMETER_MOVE_EVADE.SHORT,
					FMOD_PARAMETER_MOVE_EVADE.LONG,
					FMOD_PARAMETER_MOVE_EVADE.LAND
				])
		]);

	event_per_enum[? FMOD_EVENT.HANG] = new FmodEvent(
		"event:/SFX/CHARACTER/MAIN_ARARIBOIA/BASIC_MOVES/sfx_main_hanging", [ ]);
	
	event_per_enum[? FMOD_EVENT.HIT_GROUND] = new FmodEvent(
		"event:/SFX/CHARACTER/MAIN_ARARIBOIA/BASIC_MOVES/sfx_main_hit_ground", []);
		
	event_per_enum[? FMOD_EVENT.HURT] = new FmodEvent(
		"event:/SFX/CHARACTER/MAIN_ARARIBOIA/BASIC_MOVES/sfx_main_hurt", [ ]);
	
	event_per_enum[? FMOD_EVENT.JUMP] = new FmodEvent(
		"event:/SFX/CHARACTER/MAIN_ARARIBOIA/BASIC_MOVES/sfx_main_jump", 
		[
			new FmodParameter(
				FMOD_PARAMETER_NAME_MOVE, 
				[
					FMOD_PARAMETER_MOVE_JUMP.JUMP,
					FMOD_PARAMETER_MOVE_JUMP.DOUBLE_JUMP,
					FMOD_PARAMETER_MOVE_JUMP.LAND
				])
		]);
	
	event_per_enum[? FMOD_EVENT.WALK] = new FmodEvent(
		"event:/SFX/CHARACTER/MAIN_ARARIBOIA/BASIC_MOVES/sfx_main_run",
		[
			new FmodParameter(
				FMOD_PARAMETER_NAME_MOVE, 
				[
					FMOD_PARAMETER_MOVE_WALK.STONE,
					FMOD_PARAMETER_MOVE_WALK.GRASS,
					FMOD_PARAMETER_MOVE_WALK.SAND,
					FMOD_PARAMETER_MOVE_WALK.WOOD,
					FMOD_PARAMETER_MOVE_WALK.DIRT,
					FMOD_PARAMETER_MOVE_WALK.WATER,
				])
		]);	
		
	#endregion
	
	#region OBJECTS
	
	event_per_enum[? FMOD_EVENT.OBJECTS_FIRE] = new FmodEvent(
		"event:/SFX/OBJECTS/FIRE/sfx_objects_fire", [ ]);
	
	#endregion
	
	#region WOOD_BARRIER
	
	event_per_enum[? FMOD_EVENT.WOOD_BARRIER_BREAK] = new FmodEvent(
		"event:/SFX/OBJECTS/WOOD_BARRIER/sfx_object_wood_barrier_break",
		[
			new FmodParameter(
				FMOD_PARAMETER_NAME_MOVE, 
				[
					FMOD_PARAMETER_MOVE_VALUE_WOOD_BREAK.HIT,
					FMOD_PARAMETER_MOVE_VALUE_WOOD_BREAK.BREAK
				])
		]);
		
	event_per_enum[? FMOD_EVENT.WOOD_BARRIER_DEBRIS] = new FmodEvent(
		"event:/SFX/OBJECTS/WOOD_BARRIER/sfx_object_wood_barrier_debris", []);	
	
	#endregion
	
	#region UI
	
	event_per_enum[? FMOD_EVENT.BUTTON_TALK] = new FmodEvent(
		"event:/SFX/UI/BUTTONS/sfx_ui_buttons_talk", [ ]);
		
	event_per_enum[? FMOD_EVENT.MENU_CONFIRM_RETURN] = new FmodEvent(
		"event:/SFX/UI/BUTTONS/sfx_ui_menu_confirm_return", [ ]);
		
	event_per_enum[? FMOD_EVENT.MENU_GENERAL] = new FmodEvent(
		"event:/SFX/UI/BUTTONS/sfx_ui_menu_general", [ ]);
		
	event_per_enum[? FMOD_EVENT.MENU_NEWGAME_LOADGAME] = new FmodEvent(
		"event:/SFX/UI/BUTTONS/sfx_ui_menu_newgame_loadgame", [ ]);
		
	event_per_enum[? FMOD_EVENT.MENU_PAUSE] = new FmodEvent(
		"event:/SFX/UI/BUTTONS/sfx_ui_menu_pause", [ ]);
		
	event_per_enum[? FMOD_EVENT.COLLECT_LIFE] = new FmodEvent(
		"event:/SFX/UI/COLECTABLES/sfx_colect_life", [ ]);
		
	event_per_enum[? FMOD_EVENT.COLLECT_REGISTER] = new FmodEvent(
		"event:/SFX/UI/COLECTABLES/sfx_colect_register", [ ]);
		
	event_per_enum[? FMOD_EVENT.TRANSITION_BOAT] = new FmodEvent(
		"event:/SFX/UI/TRANSITIONS/sfx_ui_transition_boat", [ ]);
	
	#endregion
}

function load_busses()
{
	busses_per_enum[? FMOD_BUS.MASTER] = fmod_studio_system_get_bus("bus:/");
}

function load_vcas()
{
	vcas_per_enum[? FMOD_VCA.MUSIC]	= fmod_studio_system_get_vca("vca:/MUSIC");
	vcas_per_enum[? FMOD_VCA.SFX] = fmod_studio_system_get_vca("vca:/SFX");
	vcas_per_enum[? FMOD_VCA.SFX_GAMEPLAY] = fmod_studio_system_get_vca("vca:/SFX GAMEPLAY");
	vcas_per_enum[? FMOD_VCA.SFX_UI] = fmod_studio_system_get_vca("vca:/SFX UI");
}

function set_volume(_vca = FMOD_VCA.SFX_GAMEPLAY, _volume = 1) 
{
	fmod_studio_vca_set_volume(vcas_per_enum[? _vca], _volume);
} 

function on_options_change(_options = new OptionsModel())
{
	master_enabled	= _options.master_enabled;
	music_enabled	= _options.music_enabled;
	sfx_enabled		= _options.sfx_enabled;
	deaf_assistance = _options.deaf_assistance;
	
	master_volume	= _options.master_volume / 10;
	music_volume	= _options.music_volume / 10;
	sfx_volume		= _options.sfx_volume / 10;
	
	fmod_studio_bus_set_volume(busses_per_enum[? FMOD_BUS.MASTER], master_enabled ? master_volume : 0);
	
	fmod_studio_vca_set_volume(vcas_per_enum[? FMOD_VCA.MUSIC], music_enabled ? music_volume : 0);
	fmod_studio_vca_set_volume(vcas_per_enum[? FMOD_VCA.SFX], sfx_enabled ? sfx_volume : 0);
	
	fmod_studio_vca_set_volume(vcas_per_enum[? FMOD_VCA.SFX_GAMEPLAY], 1);
	fmod_studio_vca_set_volume(vcas_per_enum[? FMOD_VCA.SFX_UI], 1);
}

function create_3d_attributes()
{
	fmod_3d_att = new Fmod3DAttributes();
	fmod_3d_att.forward.z = -1;
	fmod_3d_att.up.y = -1;
	
	fmod_3d_att.position.x = 0;
	fmod_3d_att.position.y = 0;

	fmod_studio_system_set_listener_attributes(0, fmod_3d_att);
}

function init() 
{
	load_fmod();
	
	load_events();
	
	load_vcas();
	
	load_busses();
	
	create_3d_attributes();
}

init();