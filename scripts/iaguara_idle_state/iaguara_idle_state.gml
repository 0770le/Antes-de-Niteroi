
function iaguara_idle_state() {
	
	//sees player
	if alert  {//combat
		stare();
		state = iaguara_states.CHASE;
		image_index = 0;
				
	} else {//!alert	
		state = iaguara_states.IDLE;
		image_index = 0;
	} 
	
	calc_entity_movement();
	//apply movement
	collision();
	
}

