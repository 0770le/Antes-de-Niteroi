function iaguara_jump_state(){
	
	
	//check state after anim
	if (anim_end() and on_ground()) {
		state = iaguara_states.LANDING;
		image_index = 0;
	}	
	

	//apply movement
	collision();
	
	//caculate movement
	calc_entity_movement();
}