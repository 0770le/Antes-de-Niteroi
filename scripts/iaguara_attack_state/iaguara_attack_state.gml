function iaguara_attack_state(){
	
	hsp = 0;
	
	if (image_index < image_number/2) {
		stare();
	}	
		
	if (anim_end()) {
		//jump
		state = iaguara_states.JUMP;
		image_index= 0;
		launch(5,7);
	}
	
}