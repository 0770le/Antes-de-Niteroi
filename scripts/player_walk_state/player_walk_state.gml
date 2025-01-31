
function player_walk_state(){
 
	//get input
	get_input();
	
	if(up) {
		o_camera.y_offset = -80;
	}

	//caculate movement  
	calc_movement();
	
	//check state
	if (hsp == 0) {
		state = states.IDLE;
	}
	
	var _tile = play_walk_sound(image_index, image_speed,[2,7], x, y);
	
	if(!is_undefined(_tile) and _tile == FMOD_PARAMETER_MOVE_WALK.DIRT) {
		emit_smoke(x + (5*facing),bbox_bottom,0.1,0.3,1,1);	
	}
	
	 //check if falling off ledge
	var _bottom = bbox_bottom;
	var t1 = tilemap_get_at_pixel(global.map, bbox_left, _bottom + 1);
	var t2 = tilemap_get_at_pixel(global.map, bbox_right, _bottom + 1);
	 
	if ((t1 == VOID) and (t2 == VOID)) {
	state= states.JUMP;
	}
	 
	 
	if (attack and can_attack) { 
	 //consistencia no ataque parado
		if(!left and !right) {
			hsp = 0;
			state = states.ATTACK;
			image_index =0;
			can_attack = false;
			alarm[ATTACKING]= attack_delay;
			o_sound_controller.update_event_parameter_and_play_pos(FMOD_EVENT.ATTACK_MELEE, FMOD_PARAMETER_NAME_MOVE, FMOD_PARAMETER_MOVE_VALUE_MELEE_ATTACK.GROUND_PREPARE,x,y);
		} else { //ataque movendo
			state =	states.ATTACK_WALK;
			image_index =0;
			can_attack = false;
			alarm[ATTACKING]= attack_delay/2;
			launch(0,abs(hsp*0.7), -1*facing); //tranco do hit
			o_sound_controller.update_event_parameter_and_play_pos(FMOD_EVENT.ATTACK_MELEE, FMOD_PARAMETER_NAME_MOVE, FMOD_PARAMETER_MOVE_VALUE_MELEE_ATTACK.MOVING,x,y);
		}
	}
	
	if jump {
		jumped();
	}
	
	if evade {
		evaded();
		image_index =0;
	}
	
	if (has_bow and shoot and !left and !right) {
		state= states.SHOOT;
		image_index =0;
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