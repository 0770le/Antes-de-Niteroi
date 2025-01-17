
function chevalier_idle_state() {
	
	//sees player
	if alert  {//combat
		
		state = chevalier_states.ENGAGED;
		image_index = 0;
		
	} 

	turn();
	
	//physics
	calc_entity_movement();
	collision();
	
}

