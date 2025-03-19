
function tupinamba_melee_idle_state() {
	
	//enter state,set wait time

	if !in_idle_state {
		//next patrol 
		wait_time = random_range(2, 4) * room_speed;
		image_speed=1;
		image_index = 0;
		in_idle_state = true;
	} //seting var in step
	
	//sees player
	if alert  {//combat
		stare();
		//player e tupi fora do limite do patrol 
		if (x < patrol_left_limit or x > patrol_right_limit) 
		and (o_player.x < patrol_left_limit or o_player.x > patrol_right_limit) {	
			
			//if wait_time-- < 0 {
				//taunt
			//}
			
		} else { //inside patrol area
			//next to player
			if ((abs(x - o_player.x) < attack_range) ){
				state = tupinamba_melee_states.IDLE;
				
				////if player is in other y, evade to follow 
				if ((x == xprevious and abs(y - o_player.y) > TILE_SIZE*2 and y < o_player.y) ){ // and (o_player.x == o_player.xprevious)) {
					if (has_evade) {
						has_evade = false;			
						evade_delay = evade_delay_initial;
						tupinamba_melee_evaded();	
					}
				}
				
			} else { //	chase	
				state = tupinamba_melee_states.CHASE;
				image_index = 0;
				
			}
		}
			
	} else {//!alert
		//patrol  
		if patrol and wait_time-- < 0  {
			state = tupinamba_melee_states.PATROL;
			image_index = 0;
		} 
	}

	
	calc_entity_movement();
	//apply movement
	collision();
	
}

