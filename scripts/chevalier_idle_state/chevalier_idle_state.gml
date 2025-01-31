
function chevalier_idle_state() {
	
	//sees player
	if (alert  and o_player.hp > 0)  {//combat
		
		state = chevalier_states.ENGAGED;
		image_index = 0;
		
	} 

	if(aerial_riposte()) {
		return;	
	}
	turn();
	
	//physics
	calc_entity_movement();
	collision();
	
}

