
function player_crouch_state(){
	//get input
	get_input();
	
	//calculate movement
	calc_movement();
	
	//check state
	if down {
		hsp=0;
	} else {
		state = states.IDLE;
		o_sound_controller.update_event_parameter_and_play_pos(FMOD_EVENT.CROUCH, FMOD_PARAMETER_NAME_MOVE, FMOD_PARAMETER_MOVE_CROUCH.CROUCH, x, y);
	}
		
	if (alarm[HIDING] == 0) {
		hide_check() 
	} 
	
	if (hsp != 0) {
		state = states.WALK;
	}
	
	if (attack and can_attack){
		state =	states.ATTACK;
		image_index = 0;
		can_attack = false;
		alarm[ATTACKING]= attack_delay;
		o_sound_controller.update_event_parameter_and_play(FMOD_EVENT.ATTACK_MELEE, FMOD_PARAMETER_NAME_MOVE, FMOD_PARAMETER_MOVE_VALUE_MELEE_ATTACK.GROUND_PREPARE)
	}
	
	if (has_bow and shoot and arrows > 0) {
		state = states.SHOOT;
		image_index = 0;
	}
	
	if evade {
		evaded();
	} 
	
	//allow player descend on plataforms
	var vt1 = tilemap_get_at_pixel(global.map, bbox_left, bbox_bottom +1);
	var vt2 = tilemap_get_at_pixel(global.map, bbox_right, bbox_bottom +1);
	
	if jump and (vt1 == PLATAFORM or vt2 == PLATAFORM){
		state = states.JUMP;
		y += 1;
	}
	
	
	
	//apply movement
	collision();
	//check player hp
	check_player_hp();
	//aply animation
	anim();
}
