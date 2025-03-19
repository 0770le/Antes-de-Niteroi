
function iaguara_idle_state() {
	
	//sees player
	if alert  {//combat
		stare();
		state = iaguara_states.CHASE;
		image_index = 0;
				
	}
	
	calc_entity_movement(global.grav, 0.3);
	//apply movement
	collision();
	
}

