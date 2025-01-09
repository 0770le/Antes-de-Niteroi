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

function play(_event_enum = FMOD_EVENT.WEATHER_AMBIENCE, _stop = true)
{
	if(_stop) event_per_enum[? _event_enum].stop();
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
	event_per_enum[? _event_enum].update_position(_x, _y);
}

function update_event_parameter(_event_enum = FMOD_EVENT.WEATHER_AMBIENCE, 
								_parameter_name = undefined, 
								_parameter_value = undefined)
{
	event_per_enum[? _event_enum].update_parameter(_parameter_name, _parameter_value);
}

function update_event_parameter_and_play(_event_enum = FMOD_EVENT.WEATHER_AMBIENCE, 
										 _parameter_name = undefined, 
										 _parameter_value = undefined,
										 _stop = true)
{
	if(_stop) event_per_enum[? _event_enum].stop();
	event_per_enum[? _event_enum].update_parameter(_parameter_name, _parameter_value);
	event_per_enum[? _event_enum].play();
}

function update_event_parameter_and_play_pos(_event_enum = FMOD_EVENT.WEATHER_AMBIENCE, 
										 _parameter_name = undefined, 
										 _parameter_value = undefined,
										 _x = 0,
										 _y = 0,
										 _stop = true)
{
	if(_stop) event_per_enum[? _event_enum].stop();
	event_per_enum[? _event_enum].update_parameter(_parameter_name, _parameter_value);
	event_per_enum[? _event_enum].update_position(_x, _y);
	event_per_enum[? _event_enum].play();
}

function load_fmod()
{
	fmod = instance_create_depth(0, 0, 0, obj_fmod);
	obj_fmod.
	
	master_bank_index = fmod_studio_system_load_bank_file(fmod_path_bundle("sounds/Master.bank"), FMOD_STUDIO_LOAD_BANK.NORMAL);
	
	master_strings_bank_index = fmod_studio_system_load_bank_file(fmod_path_bundle("sounds/Master.strings.bank"), FMOD_STUDIO_LOAD_BANK.NORMAL);
}

function load_events()
{
	#region loops
		
			
	#endregion
	
	#region PLAYER
	
	//event_per_enum[? FMOD_EVENT.ATTACK_MELEE_GROUND_HIT] = new FmodEvent("event:/SFX/CHARACTER/MAIN_ARARIBOIA/ATTACK_MOVES/sfx_main_atk_melee");
	event_per_enum[? FMOD_EVENT.ATTACK_MELEE] = new FmodEvent(
		"event:/SFX/CHARACTER/MAIN_ARARIBOIA/ATTACK_MOVES/sfx_main_atk_melee",
		[
			new FmodParameter(FMOD_PARAMETER_NAME_MOVE, [
			FMOD_PARAMETER_MOVE_VALUE_MELEE_ATTACK.GROUND_PREPARE,
			FMOD_PARAMETER_MOVE_VALUE_MELEE_ATTACK.GROUND_HIT,
			FMOD_PARAMETER_MOVE_VALUE_MELEE_ATTACK.MOVING,
			FMOD_PARAMETER_MOVE_VALUE_MELEE_ATTACK.AIR]),
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
		
		event_per_enum[? FMOD_EVENT.TUPI_MELEE_ATK] = new FmodEvent(
		"event:/SFX/CHARACTER/ENEMIES/MELEE_TUPINAMBA/sfx_enem_tupi_melee_atk",
		[
			new FmodParameter(FMOD_PARAMETER_NAME_MOVE, [
			FMOD_PARAMETER_MOVE_VALUE_TUPI_MELEE_ATK.MISS,
			FMOD_PARAMETER_MOVE_VALUE_TUPI_MELEE_ATK.GROUND_HIT]),
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
	music_enabled	= _options.music_enabled;
	sfx_enabled		= _options.sfx_enabled;
	music_volume	= _options.music_volume;
	sfx_volume		= _options.sfx_volume;
	master_enabled	= _options.master_enabled;
	master_volume	= _options.master_volume;
	
	fmod_studio_bus_set_volume(busses_per_enum[? FMOD_BUS.MASTER], master_enabled ? (master_volume / 100) : 0);
	
	fmod_studio_vca_set_volume(vcas_per_enum[? FMOD_VCA.MUSIC], music_enabled ? (music_volume / 100) : 0);
	fmod_studio_vca_set_volume(vcas_per_enum[? FMOD_VCA.SFX],   sfx_enabled ?   (sfx_volume   / 100) : 0);
}

function init() 
{
	load_fmod();
	
	load_events();
	
	load_vcas();
	
	load_busses();
	
	//obj_options_controller.register_options_listener(self);
	
	//on_options_change(obj_options_controller.options);
	//fmod_studio_bus_set_volume(busses_per_enum[? FMOD_BUS.MASTER], 1);//master_enabled ? (master_volume / 100) : 0);
	
	//fmod_studio_vca_set_volume(vcas_per_enum[? FMOD_VCA.MUSIC], 1);// music_enabled ? (music_volume / 100) : 0);
	//fmod_studio_vca_set_volume(vcas_per_enum[? FMOD_VCA.SFX],   1);// sfx_enabled ?   (sfx_volume   / 100) : 0);
	
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