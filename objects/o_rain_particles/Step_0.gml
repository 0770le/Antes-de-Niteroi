if(!is_on and o_player.x <= 4020) {
	start();
	part_emitter_stream(particle_system, particle_emitter1, particle_type1, -8);
	part_emitter_stream(particle_system, particle_emitter2, particle_type2, -4);
} else if(is_on and o_player.x > 3620) {
	stop();
}

if(is_on and global.timer mod 5 == 0) {
	
	var _parameter_value = FMOD_PARAMETER_VALUE_AMBIENCE_KERYL.NO_RAIN;
	
	if(global.player.x < 2100) {
		part_emitter_stream(particle_system, particle_emitter1, particle_type1, 15);
		part_emitter_stream(particle_system, particle_emitter2, particle_type2, 30);
		_parameter_value = FMOD_PARAMETER_VALUE_AMBIENCE_KERYL.HEAVY_RAIN;
	} else if (global.player.x < 2300) {
		part_emitter_stream(particle_system, particle_emitter1, particle_type1, 12);
		part_emitter_stream(particle_system, particle_emitter2, particle_type2, 25);
		_parameter_value = FMOD_PARAMETER_VALUE_AMBIENCE_KERYL.MEDIUM_RAIN;
	} else if (global.player.x < 2600) {
		part_emitter_stream(particle_system, particle_emitter1, particle_type1, 9);
		part_emitter_stream(particle_system, particle_emitter2, particle_type2, 18);
		_parameter_value = FMOD_PARAMETER_VALUE_AMBIENCE_KERYL.LIGHT_RAIN;
	} else if (global.player.x < 2900) {
		part_emitter_stream(particle_system, particle_emitter1, particle_type1, 4);
		part_emitter_stream(particle_system, particle_emitter2, particle_type2, 9);
		_parameter_value = FMOD_PARAMETER_VALUE_AMBIENCE_KERYL.LIGHT_RAIN;
	} else if (global.player.x < 3520) {
		part_emitter_stream(particle_system, particle_emitter1, particle_type1, 1);
		part_emitter_stream(particle_system, particle_emitter2, particle_type2, 2);
		_parameter_value = FMOD_PARAMETER_VALUE_AMBIENCE_KERYL.NO_RAIN;
	}
	
	global.sound_controller.update_event_parameter_and_play_pos(
		FMOD_EVENT.AMBIENCE_KERYL, 
		FMOD_PARAMETER_NAME_AMBIENCE,
		_parameter_value,
		global.player.x, global.player.y
	);	
	
	x_start = global.cx - 50;	
	x_end = global.cx + 50 + global.cw; 
	y_start = global.cy - 50;
	y_end = global.cy + 50 + global.ch;
	
	part_emitter_region(particle_system, particle_emitter1, x_start, x_end, y_start, y_end, ps_shape_rectangle, ps_distr_linear);
	part_emitter_region(particle_system, particle_emitter2, x_start, x_end, y_start, y_end, ps_shape_rectangle, ps_distr_linear);
}