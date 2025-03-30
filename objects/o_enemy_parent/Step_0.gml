if (!instance_exists(o_fade)) {
	if(!place_meeting(x,y,o_vision_blocker_2)){
		script_execute (states_array[state]);
	}
	
	check_enemy_hp();
	
	if (can_alert) {
		check_alert();
	}
		
	if (instance_exists(o_player) and o_player.hp < 0) {
		alert = false;
	}
	
	//anim
	enemy_anim();
	
	//not allow facing = 0;
	if (image_xscale == 0) {
		image_xscale = 1;
	}
	
	
	//seta a visibilidade o oposto de hidden
	//visible = !hidden;
	if (hidden) {
		image_alpha = lerp (image_alpha, 0.8, 0.02);
	} else {
		image_alpha = lerp (image_alpha, 1, 0.1);
	}
	
	
} else {
	image_index = 0;
}

process_state_update(previous_state, state);

