
function frances_idle_state() {
image_speed=1;
//sees player
	if alert {
		stare()
		
		////avoid arrow
		//if (distance_to_object(o_player_arrow) < TILE_SIZE) {
		//	state = frances_states.DUCK;
		//	image_index = 0;
		//	image_speed = 1;
		//}
		
		
		if o_player.hp > 0 {
			//reload
			if !can_fire {
				state = frances_states.RELOAD;
				image_index = 0;
				image_speed = 1;
				
			//fire	
			} else { 
				state = frances_states.SHOOT;
				image_index = 0;
				image_speed = 1;
			}
		}
	//not alert	
	} else {
		//patrol  
		if patrol and wait_time-- < 0  {
			state = frances_states.PATROL;
			image_index = 0;
			image_speed = 1;
		} 
	}
	
	calc_entity_movement();
	//apply movement
	collision();
	
}

