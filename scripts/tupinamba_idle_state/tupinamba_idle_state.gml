
function tupinamba_idle_state(){

	//change state

	//shoot
	if (can_fire == true) and alert {
		state = tupinamba_states.SHOOT;
		image_index=0;
	} 
	
	
	//apply movement
	collision();
	
}

