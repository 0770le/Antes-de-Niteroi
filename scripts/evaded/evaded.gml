///standar evade leap off the ground
function evaded() {
	if (((jumps > 0) or on_ground()) and has_evade) {
		
		jumpTimer = 0;
		
		if(left) {
			facing = -1;	
		}if(right) {
			facing = 1;	
		}
		recover_time = 0;
		image_index = 0;
		image_speed = 1;
		scale_x = scale_min;
		scale_y = scale_max;
		vsp_decimal = 0;
		hsp_decimal = 0;
		state = states.EVADE;
		
		//making dust contraria
		jump_dust();
		
		//wings in air evade
		if (!on_ground() and jumps > 0){
			with(instance_create_depth(x,y,depth-1,o_generic_animation)) {
				attached_to = other.id;
				attach_y_off = -33;
				attach_x_off = -5;
				sprite_index = s_player_wing_evade;
				destroy = true;
			}
			o_sound_controller.update_event_parameter_and_play_pos(FMOD_EVENT.JUMP, FMOD_PARAMETER_NAME_MOVE, FMOD_PARAMETER_MOVE_JUMP.DOUBLE_JUMP,x,y);
		}
		
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