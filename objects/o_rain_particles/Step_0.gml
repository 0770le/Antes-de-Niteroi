if(!is_on and o_player.x <= 4020) {
	start();
	part_emitter_stream(particle_system, particle_emitter1, particle_type1, -8);
	part_emitter_stream(particle_system, particle_emitter2, particle_type2, -4);
	
	global.sound_controller.update_event_parameter_and_play_pos(
		FMOD_EVENT.AMBIENCE_KERYL, 
		FMOD_PARAMETER_NAME_AMBIENCE,
		FMOD_PARAMETER_VALUE_AMBIENCE_KERYL.NO_RAIN,
		global.player.x, global.player.y
	)
	
	state = RAIN_STATE.NONE;
			
} else if(is_on and o_player.x > 3620) {
	stop();
	
	global.sound_controller.stop(FMOD_EVENT.AMBIENCE_KERYL);
}

if(is_on and global.timer mod 5 == 0) {
	
	var _previous_state = state;
	
	if(global.player.x < 2100) {
		part_emitter_stream(particle_system, particle_emitter1, particle_type1, 15);
		part_emitter_stream(particle_system, particle_emitter2, particle_type2, 30);
		state = RAIN_STATE.RIO_DE_JANEIRO;
	} else if (global.player.x < 2300) {
		part_emitter_stream(particle_system, particle_emitter1, particle_type1, 12);
		part_emitter_stream(particle_system, particle_emitter2, particle_type2, 25);
		state = RAIN_STATE.HEAVY;
	} else if (global.player.x < 2600) {
		part_emitter_stream(particle_system, particle_emitter1, particle_type1, 9);
		part_emitter_stream(particle_system, particle_emitter2, particle_type2, 18);
		state = RAIN_STATE.MEDIUM;
	} else if (global.player.x < 2900) {
		part_emitter_stream(particle_system, particle_emitter1, particle_type1, 4);
		part_emitter_stream(particle_system, particle_emitter2, particle_type2, 9);
		state = RAIN_STATE.LIGHT;
	} else if (global.player.x < 3520) {
		part_emitter_stream(particle_system, particle_emitter1, particle_type1, 1);
		part_emitter_stream(particle_system, particle_emitter2, particle_type2, 2);
		state = RAIN_STATE.NONE;
	}
	
	if (_previous_state < state)
	{
		global.deaf_assistant.show_captions("Chuva intensifica");
		
		var _fmod_parameter = get_fmod_parameter_by_state(state);
		
		global.sound_controller.update_event_parameter(
			FMOD_EVENT.AMBIENCE_KERYL, 
			FMOD_PARAMETER_NAME_AMBIENCE,
			_fmod_parameter
		);
	}
	else if (_previous_state > state)
	{
		global.deaf_assistant.show_captions("Chuva diminui");
		
		var _fmod_parameter = get_fmod_parameter_by_state(state);
		
		global.sound_controller.update_event_parameter(
			FMOD_EVENT.AMBIENCE_KERYL, 
			FMOD_PARAMETER_NAME_AMBIENCE,
			_fmod_parameter
		);
	}
	
	x_start = global.cx - 50;	
	x_end = global.cx + 50 + global.cw; 
	y_start = global.cy - 50;
	y_end = global.cy + 50 + global.ch;
	
	part_emitter_region(particle_system, particle_emitter1, x_start, x_end, y_start, y_end, ps_shape_rectangle, ps_distr_linear);
	part_emitter_region(particle_system, particle_emitter2, x_start, x_end, y_start, y_end, ps_shape_rectangle, ps_distr_linear);
}