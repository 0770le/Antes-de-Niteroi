function chevalier_engaged_state(){
	
	if (!alert) {//!alert
		state = chevalier_states.IDLE;
		image_index = 0;
	} 
	
	turn();
	aerial_riposte();
	
	//player e chevalier fora do limite do patrol 
	if (x < patrol_left_limit or x > patrol_right_limit) 
	and (o_player.x < patrol_left_limit or o_player.x > patrol_right_limit) {	
			
		//hold
	
	} else { // inside patrol area	
		
		//if in range	
		if (distance_to_object(o_player) < attack_range) {
			chevalier_attack();
		} else { //out of range
			//chase	
			state = chevalier_states.CHASE;
			image_index = 0;
				
		}
	}


	//physics
	calc_entity_movement();
	collision();
	
}