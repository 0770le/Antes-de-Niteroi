

function armadeira_jump_state(){
	calc_entity_movement();
	
	if(on_ground()) {
		hsp=0;
		state = armadeira_states.ATTACK;
	} 
	
	//apply movement
	collision();

}