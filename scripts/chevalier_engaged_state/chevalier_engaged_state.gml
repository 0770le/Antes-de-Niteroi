function chevalier_engaged_state(){
	
	if (!alert or  o_player.hp <= 0) {//!alert
		state = chevalier_states.IDLE;
		image_index = 0;
	} 
	
	turn();
	//if(aerial_riposte()) {
	//	return;	
	//}
	
	if(attack_up()) {
		return;
	}
	
	//player e chevalier fora do limite do patrol 
	if (x < patrol_left_limit or x > patrol_right_limit) 
	and (o_player.x < patrol_left_limit or o_player.x > patrol_right_limit) {	
			
		//hold
	
	} else { // inside patrol area	
		
		//if in range	
		if (distance_to_object(o_player) < attack_range) {
			chevalier_attack();
		} else if(abs(x-o_player.x) > 50){ //out of range
			//chase	
			state = chevalier_states.CHASE;
			image_index = 0;
				
		}
	}


	//physics
	calc_entity_movement();
	collision();
	
}