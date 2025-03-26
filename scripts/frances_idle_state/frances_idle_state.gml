
function frances_idle_state() {
//sees player
	if alert {
		stare()
		
		////avoid arrow
		//if (distance_to_object(o_player_arrow) < TILE_SIZE) {
		//	state = frances_states.DUCK;
		//	image_index = 0;
		//}
		
		
		if (line_of_sight(true) and abs(y-o_player.y)< 30 and on_screen(-20)) {
			//reload
			if !can_fire {
				state = frances_states.RELOAD;
				image_index = 0;
				
			//fire	
			} else { 
				state = frances_states.SHOOT;
				image_index = 0;
			}
		} else if(abs(o_player.x - x) < 200) {
			state = frances_states.RUN;
		}
	//not alert	
	} else {
		//patrol  
		if patrol and wait_time-- < 0  {
			state = frances_states.PATROL;
			image_index = 0;
		} 
	}
	
	calc_entity_movement();
	//apply movement
	collision();
	
}

