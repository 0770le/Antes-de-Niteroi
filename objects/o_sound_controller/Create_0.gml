global.sound_controller = self;

fmod						= noone;
master_bank_index			= noone;
master_strings_bank_index	= noone;
event_per_enum				= ds_map_create();
vcas_per_enum				= ds_map_create();
busses_per_enum				= ds_map_create();

music_enabled				= true;
sfx_enabled					= true;
music_volume				= 100;
sfx_volume					= 100;

fmod_3d_att					= undefined;
sound_visuals				= undefined;
music_parameter				= FMOD_PARAMETER_MUSIC_VALUE.INTRO;
is_playing_music			= false;
deaf_assistance				= false;

function on_camera_update(_x, _y) 
{
	global.logger.trace($"on_camera_update: listener position updated x: {_x}, y: {_y}"); 
	
	fmod_3d_att.position.x = _x;
	fmod_3d_att.position.y = _y;
	
	fmod_3d_att.forward.z = -1;
 	fmod_3d_att.up.y = -1;

	fmod_studio_system_set_listener_attributes(0, fmod_3d_att);
	
	update_event_position(FMOD_EVENT.CIDADE_VELHA_ROOM_AMBIENCE, _x, _y);
}

function play_music()
{
	update_event_parameter_and_play(
		FMOD_EVENT.MUSIC_GAMEPLAY, 
		FMOD_PARAMETER_NAME_MUSIC,
		global.options_controller.get_option(OPTIONS_MUSIC_PARAMETER)
	);
		
	is_playing_music = true;
}

function stop_music()
{
	if (is_playing_music)
	{
		stop(FMOD_EVENT.MUSIC_GAMEPLAY);
		
		is_playing_music = false;
	}
}

function play(_event_enum = FMOD_EVENT.MUSIC_GAMEPLAY)
{
	event_per_enum[? _event_enum].play();
}

function stop(_event_enum = FMOD_EVENT.MUSIC_GAMEPLAY)
{
	event_per_enum[? _event_enum].stop();
}

function update_event_position(_event_enum = FMOD_EVENT.MUSIC_GAMEPLAY, 
								_x = other.x, 
								_y = other.y)
{
	event_per_enum[? _event_enum].update_position(_x, _y);
}

function update_position_and_play(_event_enum = FMOD_EVENT.MUSIC_GAMEPLAY, 
								_x = other.x, 
								_y = other.y)
{
	event_per_enum[? _event_enum].update_position(_x, _y);
	event_per_enum[? _event_enum].play();
}

function update_event_parameter(_event_enum = FMOD_EVENT.MUSIC_GAMEPLAY, 
								_parameter_name = undefined, 
								_parameter_value = undefined)
{
	event_per_enum[? _event_enum].update_parameter(_parameter_name, _parameter_value);
}

function update_event_parameter_and_play(_event_enum = FMOD_EVENT.MUSIC_GAMEPLAY, 
										 _parameter_name = undefined, 
										 _parameter_value = undefined)
{
	event_per_enum[? _event_enum].update_parameter(_parameter_name, _parameter_value);
	event_per_enum[? _event_enum].play();
}

function update_event_parameter_and_play_pos(_event_enum = FMOD_EVENT.MUSIC_GAMEPLAY, 
										 _parameter_name = undefined, 
										 _parameter_value = undefined,
										 _x = 0,
										 _y = 0)
{
	event_per_enum[? _event_enum].update_parameter(_parameter_name, _parameter_value);
	event_per_enum[? _event_enum].update_position(_x, _y);
	event_per_enum[? _event_enum].play();
		
	if (deaf_assistance) sound_visuals.add(new SoundVisual(_x, _y));
}

function load_fmod()
{
	fmod = instance_create_depth(0, 0, 0, o_fmod);
	
	master_bank_index = fmod_studio_system_load_bank_file(fmod_path_bundle("sounds/Master.bank"), FMOD_STUDIO_LOAD_BANK.NORMAL);
	
	master_strings_bank_index = fmod_studio_system_load_bank_file(fmod_path_bundle("sounds/Master.strings.bank"), FMOD_STUDIO_LOAD_BANK.NORMAL);
}

function load_events()
{
	#region loops
		
	event_per_enum[? FMOD_EVENT.MUSIC_GAMEPLAY] = new FmodEvent(
		"event:/MUSIC/mus_gameplay_01", 
		[
			new FmodParameter(
				FMOD_PARAMETER_NAME_MUSIC, 
				[
					FMOD_PARAMETER_MUSIC_VALUE.INTRO,
					FMOD_PARAMETER_MUSIC_VALUE.ENGAGE_FIRST_ENEMY,
					FMOD_PARAMETER_MUSIC_VALUE.SIDE_ROOMS,
				])
		]);
		
	event_per_enum[? FMOD_EVENT.CIDADE_VELHA_ROOM_AMBIENCE] = new FmodEvent(
		"event:/SFX/AMBIENCE/ROOM_01_CIDADEVELHA/sfx_amb_room_01", [ ]);
	
	#endregion
	
	#region PLAYER
	
	event_per_enum[? FMOD_EVENT.ATTACK_MELEE] = new FmodEvent(
		"event:/SFX/CHARACTER/MAIN_ARARIBOIA/ATTACK_MOVES/sfx_main_atk_melee",
		[
			new FmodParameter(FMOD_PARAMETER_NAME_MOVE, [
			FMOD_PARAMETER_MOVE_VALUE_MELEE_ATTACK.GROUND_PREPARE,
			FMOD_PARAMETER_MOVE_VALUE_MELEE_ATTACK.GROUND,
			FMOD_PARAMETER_MOVE_VALUE_MELEE_ATTACK.MOVING,
			FMOD_PARAMETER_MOVE_VALUE_MELEE_ATTACK.AIR]),
		]);
		
	event_per_enum[? FMOD_EVENT.ATTACK_HIT] = new FmodEvent(
		"event:/SFX/CHARACTER/MAIN_ARARIBOIA/ATTACK_MOVES/sfx_main_atk_hit",
		[
			new FmodParameter(FMOD_PARAMETER_NAME_MOVE, [
			FMOD_PARAMETER_MOVE_VALUE_ATTACK_HIT.MELEE_HIT,
			FMOD_PARAMETER_MOVE_VALUE_ATTACK_HIT.MELEE_GROUND,
			FMOD_PARAMETER_MOVE_VALUE_ATTACK_HIT.ARROW_GROUND,
			FMOD_PARAMETER_MOVE_VALUE_ATTACK_HIT.ARROW_HIT]),
		]);
		
	event_per_enum[? FMOD_EVENT.ATTACK_BOW] = new FmodEvent(
		"event:/SFX/CHARACTER/MAIN_ARARIBOIA/ATTACK_MOVES/sfx_main_atk_bow",
		[
			new FmodParameter(FMOD_PARAMETER_NAME_MOVE, [
			FMOD_PARAMETER_ATTACK_BOW_VALUE.PREPARE,
			FMOD_PARAMETER_ATTACK_BOW_VALUE.RELEASE]),
		]);
			
	event_per_enum[? FMOD_EVENT.WALK] = new FmodEvent(
		"event:/SFX/CHARACTER/MAIN_ARARIBOIA/BASIC_MOVES/sfx_main_run",
		[
			new FmodParameter(FMOD_PARAMETER_NAME_MOVE, [
			FMOD_PARAMETER_MOVE_WALK.DIRT,
			FMOD_PARAMETER_MOVE_WALK.GRASS,
			FMOD_PARAMETER_MOVE_WALK.STONE,
			FMOD_PARAMETER_MOVE_WALK.SAND]),
		]);
			
	event_per_enum[? FMOD_EVENT.CROUCH] = new FmodEvent(
		"event:/SFX/CHARACTER/MAIN_ARARIBOIA/BASIC_MOVES/sfx_main_crouch", []);
			
	event_per_enum[? FMOD_EVENT.EVADE] = new FmodEvent(
		"event:/SFX/CHARACTER/MAIN_ARARIBOIA/BASIC_MOVES/sfx_main_evade",
		[
			new FmodParameter(FMOD_PARAMETER_NAME_MOVE, [
			FMOD_PARAMETER_MOVE_EVADE.SHORT,
			FMOD_PARAMETER_MOVE_EVADE.LONG,
			FMOD_PARAMETER_MOVE_EVADE.LAND]),
		]);
			
	event_per_enum[? FMOD_EVENT.HURT] = new FmodEvent(
		"event:/SFX/CHARACTER/MAIN_ARARIBOIA/BASIC_MOVES/sfx_main_hurt",
		[
			
		]);
			
	event_per_enum[? FMOD_EVENT.JUMP] = new FmodEvent(
		"event:/SFX/CHARACTER/MAIN_ARARIBOIA/BASIC_MOVES/sfx_main_jump", [
			new FmodParameter(FMOD_PARAMETER_NAME_MOVE, [
				FMOD_PARAMETER_MOVE_WALK.STONE,
				FMOD_PARAMETER_MOVE_WALK.GRASS,
				FMOD_PARAMETER_MOVE_WALK.SAND,
				FMOD_PARAMETER_MOVE_WALK.WOOD,
				FMOD_PARAMETER_MOVE_WALK.DIRT,
				FMOD_PARAMETER_MOVE_WALK.WATER])]);
			
	event_per_enum[? FMOD_EVENT.HANG] = new FmodEvent(
		"event:/SFX/CHARACTER/MAIN_ARARIBOIA/BASIC_MOVES/sfx_main_hanging",
		[
			
		]);
			
	event_per_enum[? FMOD_EVENT.DIE] = new FmodEvent(
		"event:/SFX/CHARACTER/MAIN_ARARIBOIA/BASIC_MOVES/sfx_main_die",
		[
			
		]);
		
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
	
	#region MELEE_TUPI
		
	event_per_enum[? FMOD_EVENT.TUPI_MELEE_ATK] = new FmodEvent(
		"event:/SFX/CHARACTER/ENEMIES/MELEE_TUPINAMBA/sfx_enem_tupi_melee_atk",
		[
			new FmodParameter(FMOD_PARAMETER_NAME_MOVE, [
			FMOD_PARAMETER_MOVE_VALUE_TUPI_MELEE_ATK.PREPARE,
			FMOD_PARAMETER_MOVE_VALUE_TUPI_MELEE_ATK.SWING]),
		]);
			
	event_per_enum[? FMOD_EVENT.TUPI_MELEE_DIE] = new FmodEvent(
		"event:/SFX/CHARACTER/ENEMIES/MELEE_TUPINAMBA/sfx_enem_tupi_melee_die",
		[
			
		]);
			
	event_per_enum[? FMOD_EVENT.TUPI_MELEE_HURT] = new FmodEvent(
		"event:/SFX/CHARACTER/ENEMIES/MELEE_TUPINAMBA/sfx_enem_tupi_melee_hurt",
		[
			
		]);
		
	event_per_enum[? FMOD_EVENT.TUPI_MELEE_JUMP] = new FmodEvent(
		"event:/SFX/CHARACTER/ENEMIES/MELEE_TUPINAMBA/sfx_enem_tupi_melee_jump",
		[
			new FmodParameter(
				FMOD_PARAMETER_NAME_MOVE, [
					FMOD_PARAMETER_VALUE_TUPI_MELEE_JUMP.JUMP,
					FMOD_PARAMETER_VALUE_TUPI_MELEE_JUMP.LAND
				])
		]);
		
	event_per_enum[? FMOD_EVENT.TUPI_MELEE_EVADE] = new FmodEvent(
		"event:/SFX/CHARACTER/ENEMIES/MELEE_TUPINAMBA/sfx_enem_tupi_melee_evade", [ ]);
		
		
		
	event_per_enum[? FMOD_EVENT.TUPI_MELEE_WALK] = new FmodEvent(
		"event:/SFX/CHARACTER/ENEMIES/MELEE_TUPINAMBA/sfx_enem_tupi_melee_run", [ 
			new FmodParameter(FMOD_PARAMETER_NAME_MOVE, [
				FMOD_PARAMETER_MOVE_WALK.STONE,
				FMOD_PARAMETER_MOVE_WALK.GRASS,
				FMOD_PARAMETER_MOVE_WALK.SAND,
				FMOD_PARAMETER_MOVE_WALK.WOOD,
				FMOD_PARAMETER_MOVE_WALK.DIRT,
				FMOD_PARAMETER_MOVE_WALK.WATER])]);
	
	#endregion
	
	
	#region ARCHER_TUPI
			
	event_per_enum[? FMOD_EVENT.TUPI_ARCHER_DIE] = new FmodEvent(
		"event:/SFX/CHARACTER/ENEMIES/ARCHER_TUPINAMBA/sfx_enem_tupi_archer_die",
		[ ]);
			
	event_per_enum[? FMOD_EVENT.TUPI_ARCHER_HURT] = new FmodEvent(
		"event:/SFX/CHARACTER/ENEMIES/ARCHER_TUPINAMBA/sfx_enem_tupi_archer_hurt",
		[ ]);
		
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
	
	#endregion
	
	
	#region FRENCH_SHOOTER
			
	event_per_enum[? FMOD_EVENT.FRENCH_SHOOTER_DIE] = new FmodEvent(
		"event:/SFX/CHARACTER/ENEMIES/SHOOTER_FRENCH/sfx_enem_french_shooter_die",
		[
			
		]);
			
	event_per_enum[? FMOD_EVENT.FRENCH_SHOOTER_HURT] = new FmodEvent(
		"event:/SFX/CHARACTER/ENEMIES/SHOOTER_FRENCH/sfx_enem_french_shooter_hurt",
		[
			
		]);
		
	event_per_enum[? FMOD_EVENT.FRENCH_SHOOTER_COUCH] = new FmodEvent(
		"event:/SFX/CHARACTER/ENEMIES/SHOOTER_FRENCH/sfx_enem_french_shooter_couch",
		[]);
		
	event_per_enum[? FMOD_EVENT.FRENCH_SHOOTER_JUMP] = new FmodEvent(
		"event:/SFX/CHARACTER/ENEMIES/SHOOTER_FRENCH/sfx_enem_french_shooter_jump",
		[
			new FmodParameter(
				FMOD_PARAMETER_NAME_MOVE, [
					FMOD_PARAMETER_VALUE_FRENCH_SHOOTER_JUMP.JUMP,
					FMOD_PARAMETER_VALUE_FRENCH_SHOOTER_JUMP.LAND
				])
		]);
	
	event_per_enum[? FMOD_EVENT.FRENCH_SHOOTER_RELOAD] = new FmodEvent(
		"event:/SFX/CHARACTER/ENEMIES/SHOOTER_FRENCH/sfx_enem_french_shooter_reload",
		[]);
	
	event_per_enum[? FMOD_EVENT.FRENCH_SHOOTER_SHOOT] = new FmodEvent(
		"event:/SFX/CHARACTER/ENEMIES/SHOOTER_FRENCH/sfx_enem_french_shooter_shoot",
		[]);
	
	#endregion
	
	#region ARMADEIRA
			
	event_per_enum[? FMOD_EVENT.SPIDER_DIE] = new FmodEvent(
		"event:/SFX/CHARACTER/ENEMIES/SPIDER/sfx_enem_spider_die",
		[
			
		]);
			
	event_per_enum[? FMOD_EVENT.SPIDER_HURT] = new FmodEvent(
		"event:/SFX/CHARACTER/ENEMIES/SPIDER/sfx_enem_spider_hurt",
		[
			
		]);
		
	event_per_enum[? FMOD_EVENT.SPIDER_ATTACK] = new FmodEvent(
		"event:/SFX/CHARACTER/ENEMIES/SPIDER/sfx_enem_spider_atk",
		[
			
		]);
	
	#endregion
	
	#region JARARACA
			
	event_per_enum[? FMOD_EVENT.SNAKE_DIE] = new FmodEvent(
		"event:/SFX/CHARACTER/ENEMIES/SNAKE/sfx_enem_snake_die",
		[
			
		]);
			
	event_per_enum[? FMOD_EVENT.SNAKE_HURT] = new FmodEvent(
		"event:/SFX/CHARACTER/ENEMIES/SNAKE/sfx_enem_snake_hurt",
		[
			
		]);
	
	#endregion
	
	#region UI
	
	event_per_enum[? FMOD_EVENT.BUTTON_TALK] = new FmodEvent(
		"event:/SFX/UI/BUTTONS/sfx_ui_buttons_talk", 
		[
		
		]);
		
	event_per_enum[? FMOD_EVENT.COLLECT_LIFE] = new FmodEvent(
		"event:/SFX/UI/COLECTABLES/sfx_colect_life", 
		[
		
		]);
		
	event_per_enum[? FMOD_EVENT.COLLECT_REGISTER] = new FmodEvent(
		"event:/SFX/UI/COLECTABLES/sfx_colect_register", 
		[
		
		]);
		
	event_per_enum[? FMOD_EVENT.TRANSITION_BOAT] = new FmodEvent(
		"event:/SFX/UI/TRANSITIONS/sfx_ui_transition_boat", 
		[
		
		]);
		
	event_per_enum[? FMOD_EVENT.MENU_CONFIRM_RETURN] = new FmodEvent(
		"event:/SFX/UI/BUTTONS/sfx_ui_menu_confirm_return", 
		[
		
		]);
		
	event_per_enum[? FMOD_EVENT.MENU_GENERAL] = new FmodEvent(
		"event:/SFX/UI/BUTTONS/sfx_ui_menu_general", 
		[
		
		]);
		
	event_per_enum[? FMOD_EVENT.MENU_NEWGAME_LOADGAME] = new FmodEvent(
		"event:/SFX/UI/BUTTONS/sfx_ui_menu_newgame_loadgame", 
		[
		
		]);
		
	event_per_enum[? FMOD_EVENT.MENU_PAUSE] = new FmodEvent(
		"event:/SFX/UI/BUTTONS/sfx_ui_menu_pause", 
		[
		
		]);
	
	#endregion
	
	#region CHEVALIER
	
	event_per_enum[? FMOD_EVENT.CHEVALIER_ATTACK_SHIELD] = new FmodEvent(
		"event:/SFX/CHARACTER/ENEMIES/CHEVALIER/sfx_enem_chev_atk_shield", 
		[
		
		]);
	
	event_per_enum[? FMOD_EVENT.CHEVALIER_ATTACK_SPEAR_PIERCE] = new FmodEvent(
		"event:/SFX/CHARACTER/ENEMIES/CHEVALIER/sfx_enem_chev_atk_spear_pierce", 
		[
		
		]);
	
	event_per_enum[? FMOD_EVENT.CHEVALIER_ATTACK_SPEAR_SLASH] = new FmodEvent(
		"event:/SFX/CHARACTER/ENEMIES/CHEVALIER/sfx_enem_chev_atk_spear_slash", 
		[
		
		]);
	
	event_per_enum[? FMOD_EVENT.CHEVALIER_DEATH] = new FmodEvent(
		"event:/SFX/CHARACTER/ENEMIES/CHEVALIER/sfx_enem_chev_death", 
		[
		
		]);
	
	event_per_enum[? FMOD_EVENT.CHEVALIER_GUARD] = new FmodEvent(
		"event:/SFX/CHARACTER/ENEMIES/CHEVALIER/sfx_enem_chev_guard", 
		[
		
		]);
	
	event_per_enum[? FMOD_EVENT.CHEVALIER_HURT] = new FmodEvent(
		"event:/SFX/CHARACTER/ENEMIES/CHEVALIER/sfx_enem_chev_hurt", 
		[
		
		]);
	
	event_per_enum[? FMOD_EVENT.CHEVALIER_TURN] = new FmodEvent(
		"event:/SFX/CHARACTER/ENEMIES/CHEVALIER/sfx_enem_chev_turn", 
		[
		
		]);
	
	event_per_enum[? FMOD_EVENT.CHEVALIER_WALK] = new FmodEvent(
		"event:/SFX/CHARACTER/ENEMIES/CHEVALIER/sfx_enem_chev_walk", 
		[
		
		]);
	
	#endregion
	
	#region HARPIA
	
	event_per_enum[? FMOD_EVENT.HARPIA_ATTACK] = new FmodEvent( 
		"event:/SFX/CHARACTER/ENEMIES/HARPIA/sfx_enem_harpia_atk", 
		[
		
		]);
		
	event_per_enum[? FMOD_EVENT.HARPIA_DIE] = new FmodEvent(
		"event:/SFX/CHARACTER/ENEMIES/HARPIA/sfx_enem_harpia_die", 
		[
		
		]);
		
	event_per_enum[? FMOD_EVENT.HARPIA_FLAP] = new FmodEvent(
		"event:/SFX/CHARACTER/ENEMIES/HARPIA/sfx_enem_harpia_flap", 
		[
		
		]);
		
	event_per_enum[? FMOD_EVENT.HARPIA_HURT] = new FmodEvent(
		"event:/SFX/CHARACTER/ENEMIES/HARPIA/sfx_enem_harpia_hurt", 
		[
		
		]);
		
	event_per_enum[? FMOD_EVENT.HARPIA_IDLE] = new FmodEvent(
		"event:/SFX/CHARACTER/ENEMIES/HARPIA/sfx_enem_harpia_idle", 
		[
		
		]);

	#endregion
}

function load_busses()
{
	busses_per_enum[? FMOD_BUS.MASTER] = fmod_studio_system_get_bus("bus:/");
}

function load_vcas()
{
	vcas_per_enum[? FMOD_VCA.MUSIC]	= fmod_studio_system_get_vca("vca:/MUSIC");
	vcas_per_enum[? FMOD_VCA.SFX]	= fmod_studio_system_get_vca("vca:/SFX");
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

function create_sound_visuals()
{
	sound_visuals = new SoundVisuals();
}

function init() 
{
	load_fmod();
	
	load_events();
	
	load_vcas();
	
	load_busses();
	
	create_3d_attributes();
	
	create_sound_visuals();
}

init();