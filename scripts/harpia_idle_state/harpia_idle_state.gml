function harpia_idle_state(){
	image_speed = 0;
	
	hsp = 0;
	dir = facing;	
	
	if(o_player .x < x-150) {
		image_index = 0;
	} else if(o_player .x < x - 50) {
		image_index = 1;
	} else if(o_player .x < x + 50) {
		image_index = 2;
	} else if(o_player .x < x + 150) {
		image_index = 3;
	} else {
		image_index = 4;
	}
	
	//Se o player estiver vivo, perto e tiver line of sight
	if(o_player.hp > 0 and distance_to_object(o_player) < alert_distance and (true_sight or line_of_sight(true,true))) {
		//se te olhar ininterruptamente por 2 segundos, ativa
		if(alert_timer-- <= 0) {
			alert = true;
			o_player.engaged = true;
			
			attack_delay = attack_cooldown;
			state = harpia_states.CHASE;
			facing = sign(o_player.x-x);
		}
	} else {
		alert_timer = alert_initial_timer;
	}
}