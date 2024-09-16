
function tupinamba_idle_state(){

	//change state
	

	//player na frente
	if line_of_sight() and alert {
		if (fire_delay <= 0) {
			state = tupinamba_states.TUPINAMBA_SHOOT;
			image_index=0;
		} 
	}

	
	
	//apply movement
	collision();
	
}

