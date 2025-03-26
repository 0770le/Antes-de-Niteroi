global.sound_controller = self;

/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor
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

music_parameter				= FMOD_PARAMETER_MUSIC_VALUE.INTRO;
is_playing_music			= false;

function play_music()
{
	if (!is_playing_music)
	{
		update_event_parameter_and_play(
			FMOD_EVENT.MUSIC_GAMEPLAY, 
			FMOD_PARAMETER_NAME_MUSIC,
			global.options_controller.get_option(OPTIONS_MUSIC_PARAMETER),
			false
		);
		
		is_playing_music = true;
	}
}

function stop_music()
{
	if (is_playing_music)
	{
		stop(FMOD_EVENT.MUSIC_GAMEPLAY);
		
		is_playing_music = false;
	}
}

function play(_event_enum = FMOD_EVENT.WEATHER_AMBIENCE)
{
	event_per_enum[? _event_enum].play();
}

function stop(_event_enum = FMOD_EVENT.WEATHER_AMBIENCE)
{
	event_per_enum[? _event_enum].stop();
}

function update_event_position(_event_enum = FMOD_EVENT.WEATHER_AMBIENCE, 
								_x, 
								_y )
{
	if(!is_undefined(_event_enum)) {
		event_per_enum[? _event_enum].update_position(_x, _y);
	}
}

function update_event_position_and_play(_event_enum = FMOD_EVENT.WEATHER_AMBIENCE, 
								_x, 
								_y )
{
	if(!is_undefined(_event_enum)) {
		event_per_enum[? _event_enum].update_position(_x, _y);
		event_per_enum[? _event_enum].play();
	}
}

function update_event_parameter(_event_enum = FMOD_EVENT.WEATHER_AMBIENCE, 
								_parameter_name = undefined, 
								_parameter_value = undefined)
{
	if(!is_undefined(_event_enum)) {
		event_per_enum[? _event_enum].update_parameter(_parameter_name, _parameter_value);
	}
}

function update_event_parameter_and_play(_event_enum = FMOD_EVENT.WEATHER_AMBIENCE, 
										 _parameter_name = undefined, 
										 _parameter_value = undefined,
										 _stop = true)
{
	if(!is_undefined(_event_enum)) {
		if(_stop) event_per_enum[? _event_enum].stop();
		event_per_enum[? _event_enum].update_parameter(_parameter_name, _parameter_value);
		event_per_enum[? _event_enum].play();
	}
}

function update_event_parameter_and_play_pos(_event_enum = FMOD_EVENT.WEATHER_AMBIENCE, 
										 _parameter_name = undefined, 
										 _parameter_value = undefined,
										 _x = 0,
										 _y = 0,
										 _stop = true)
{
	if(!is_undefined(_event_enum)) {
		if(_stop) event_per_enum[? _event_enum].stop();
		event_per_enum[? _event_enum].update_parameter(_parameter_name, _parameter_value);
		event_per_enum[? _event_enum].update_position(_x, _y);
		event_per_enum[? _event_enum].play();
	}
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
		"event:/SFX/CHARACTER/MAIN_ARARIBOIA/BASIC_MOVES/sfx_main_jump",
		[
			new FmodParameter(FMOD_PARAMETER_NAME_MOVE, [
			FMOD_PARAMETER_MOVE_JUMP.JUMP,
			FMOD_PARAMETER_MOVE_JUMP.DOUBLE_JUMP,
			FMOD_PARAMETER_MOVE_JUMP.LAND]),
		]);
			
	event_per_enum[? FMOD_EVENT.HANG] = new FmodEvent(
		"event:/SFX/CHARACTER/MAIN_ARARIBOIA/BASIC_MOVES/sfx_main_hanging",
		[
			
		]);
			
	event_per_enum[? FMOD_EVENT.DIE] = new FmodEvent(
		"event:/SFX/CHARACTER/MAIN_ARARIBOIA/BASIC_MOVES/sfx_main_die",
		[
			
		]);
		
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
	
	#endregion
	
	
	#region ARCHER_TUPI
			
	event_per_enum[? FMOD_EVENT.TUPI_ARCHER_DIE] = new FmodEvent(
		"event:/SFX/CHARACTER/ENEMIES/ARCHER_TUPINAMBA/sfx_enem_tupi_archer_die",
		[
			
		]);
			
	event_per_enum[? FMOD_EVENT.TUPI_ARCHER_HURT] = new FmodEvent(
		"event:/SFX/CHARACTER/ENEMIES/ARCHER_TUPINAMBA/sfx_enem_tupi_archer_hurt",
		[
			
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

function on_options_change(_options = instance_create_layer(0, 0, LAYER_CONTROLLERS, obj_options_instance))
{
	master_enabled	= _options.master_enabled;
	music_enabled	= _options.music_enabled;
	sfx_enabled		= _options.sfx_enabled;
	
	master_volume	= _options.master_volume / 10;
	music_volume	= _options.music_volume / 10;
	sfx_volume		= _options.sfx_volume / 10;
	
	fmod_studio_bus_set_volume(busses_per_enum[? FMOD_BUS.MASTER], master_enabled ? master_volume : 0);
	
	fmod_studio_vca_set_volume(vcas_per_enum[? FMOD_VCA.MUSIC], music_enabled ? music_volume : 0);
	fmod_studio_vca_set_volume(vcas_per_enum[? FMOD_VCA.SFX], sfx_enabled ? sfx_volume : 0);
}

function init() 
{
	load_fmod();
	
	load_events();
	
	load_vcas();
	
	load_busses();
}

function set_listener_position(_x, _y){
	var fmod_3d_att = new Fmod3DAttributes();

	fmod_3d_att.position.x = _x;
	fmod_3d_att.position.y = _y;

	fmod_3d_att.forward.z = -1;
	fmod_3d_att.up.y = -1;

	fmod_studio_system_set_listener_attributes(0,fmod_3d_att);
}

init();