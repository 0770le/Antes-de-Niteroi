
function tupinamba_idle_state() {
image_speed=1;
//sees player
	if alert {
	//shoot
		if o_player.hp > 0 and can_fire {
		state = tupinamba_states.SHOOT;
		image_index=0;
		} //else {//skirmish	
	stare()
	
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

