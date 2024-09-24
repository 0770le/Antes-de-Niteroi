
function tupinamba_idle_state() {

//sees player
	if alert {
	//shoot
		if can_fire {
		state = tupinamba_states.SHOOT;
		image_index=0;
		} //else {//skirmish	
		
	} else {
	//	//patrol  
		if patrol and wait_time-- < 0  {
			state = tupinamba_states.PATROL;
			image_index = 0;
			image_speed = 1;
		} 
	}
	
	calc_entity_movement();
	//apply movement
	collision();
	
}

