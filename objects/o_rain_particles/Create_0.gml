enum RAIN_STATE 
{
	NONE,
	LIGHT,
	MEDIUM,
	HEAVY
}

state = RAIN_STATE.NONE;

s_greayx_start = 0;
x_end = 0;
y_start = 0;
y_end = 0;

particle_system = part_system_create_layer(layer, false);

particle_type1 = part_type_create();
part_type_sprite(particle_type1, spr_rain_thick, false, false, false);
part_type_blend(particle_type1, true);
part_type_life(particle_type1, 120, 120);
part_type_alpha1(particle_type1,0.3);
part_type_direction(particle_type1,223,227,0,false);
part_type_speed(particle_type1,10,20,0,false);
	
particle_type2 = part_type_create();
part_type_sprite(particle_type2, spr_rain_thin, false, false, false);
part_type_blend(particle_type2, true);
part_type_life(particle_type2, 120, 120);
part_type_alpha1(particle_type2,0.3);
part_type_direction(particle_type2,223,227,0,false);
part_type_speed(particle_type2,10,20,0,false);
	
particle_emitter1 = part_emitter_create(particle_system);
part_emitter_region(particle_system, particle_emitter1, 0, 2750, 0, 1230, ps_shape_rectangle, ps_distr_linear);
	
particle_emitter2 = part_emitter_create(particle_system);
part_emitter_region(particle_system, particle_emitter2, 0, 2750, 0, 1230, ps_shape_rectangle, ps_distr_linear);

is_on = false;

function start()
{
	is_on = true;
}

function stop()
{
	is_on = false;
	part_emitter_stream(particle_system, particle_emitter1, particle_type1, 0);
	part_emitter_stream(particle_system, particle_emitter2, particle_type2, 0);
}

function get_fmod_parameter_by_state(_state) 
{
	switch (_state)
	{
		case RAIN_STATE.NONE: 
			return FMOD_PARAMETER_VALUE_AMBIENCE_KERYL.NO_RAIN;
		case RAIN_STATE.LIGHT: 
			return FMOD_PARAMETER_VALUE_AMBIENCE_KERYL.LIGHT_RAIN;
		case RAIN_STATE.MEDIUM:
			return FMOD_PARAMETER_VALUE_AMBIENCE_KERYL.MEDIUM_RAIN;
		case RAIN_STATE.HEAVY: 
			return FMOD_PARAMETER_VALUE_AMBIENCE_KERYL.HEAVY_RAIN;
	}
}
