///standar evade leap off the ground
function evaded() {
	if (((jumps > 0) or on_ground()) and has_evade) {
		if(left) {
			facing = -1;	
		}if(right) {
			facing = 1;	
		}
		image_index = 0;
		image_speed = 1;
		scale_x = scale_min;
		scale_y = scale_max;
		vsp_decimal = 0;
		hsp_decimal = 0;
		state = states.EVADE;
		
		//making dust contraria
		jump_dust();
		
		jumps--;
		has_evade = false;
		alarm[EVADING] = evade_delay;
		can_take_dmg = false;
		
		//allow 'rooted' evade
		if down {
			o_sound_controller.update_event_parameter_and_play_pos(FMOD_EVENT.EVADE, FMOD_PARAMETER_NAME_MOVE, FMOD_PARAMETER_MOVE_EVADE.SHORT, x, y);
			launch( (jump_spd*0.3) , 2 , -1*facing );
		}else {
			o_sound_controller.update_event_parameter_and_play_pos(FMOD_EVENT.EVADE, FMOD_PARAMETER_NAME_MOVE, FMOD_PARAMETER_MOVE_EVADE.LONG, x, y);
			launch( (jump_spd*0.3) , max_hsp*4 , -1*facing );
			
		}
	}	
}