function chevalier_turning_state(){	
	if (anim_end()) {
		stare();
		state = chevalier_states.IDLE;
		image_index = 0;
	}
	
}