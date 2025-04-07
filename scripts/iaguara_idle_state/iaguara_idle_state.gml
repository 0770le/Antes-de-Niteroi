
function iaguara_idle_state() {
	
	
	layer = layer_get_id(LAYER_INSTANCES);
	
	stare();
	//sees player
	if alert  {//combat
		state = iaguara_states.CHASE;
		image_index = 0;
				
	}
	
	calc_entity_movement(global.grav, 0.3);
	//apply movement
	collision();
	
}

