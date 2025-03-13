
function player_idle_state(){
	//get input
	get_input();
	
	if(up) {
		o_camera.y_offset = -80;
	}

	//caculate movement
	calc_movement();
	
	//check state
	if hsp != 0 state = states.WALK;

	if (attack and can_attack) {
		state = states.ATTACK;
		image_index =0;
		o_sound_controller.update_event_parameter_and_play_pos(FMOD_EVENT.ATTACK_MELEE, FMOD_PARAMETER_NAME_MOVE, FMOD_PARAMETER_MOVE_VALUE_MELEE_ATTACK.GROUND_PREPARE,x,y);
	}
	
	if( !on_ground()) {
		state = states.JUMP;
	}
	
	if jump {
		jumped();
	}
	
	if evade {
		evaded();
		image_index = 0;
	}
	
	if (shoot and o_game.has_bow and arrows >0) {
		if on_ground() and up {
			state = states.SHOOT_UP;
			image_index = 0;
		} else {
			state = states.SHOOT;
			image_index = 0;
		}	
	}
	
	if down {
		crouched();
	}
	
	
	//apply movement
	collision();

	//check player hp
	check_player_hp();
	
	//apply animations
	anim();

}