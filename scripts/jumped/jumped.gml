///standar jump off the ground
function jumped(can_jump = false) {
	
	if(!can_jump) {
		if (on_ground()) {
			can_jump = true;
			o_sound_controller.update_event_parameter_and_play_pos(FMOD_EVENT.JUMP, FMOD_PARAMETER_NAME_MOVE, FMOD_PARAMETER_MOVE_JUMP.JUMP,x,y);
		}else if(jumps > 0) {
			o_sound_controller.update_event_parameter_and_play_pos(FMOD_EVENT.JUMP, FMOD_PARAMETER_NAME_MOVE, FMOD_PARAMETER_MOVE_JUMP.DOUBLE_JUMP,x,y);
			can_jump = true;
			jumps--;
		}
	}
	
	
	
	//jumping
	if (can_jump) {
		scale_x = scale_min;
		scale_y = scale_max;
		vsp_decimal = 0;
		state = states.JUMP;
		launch(jump_spd,0); 
		evade_dust();
	}
}
