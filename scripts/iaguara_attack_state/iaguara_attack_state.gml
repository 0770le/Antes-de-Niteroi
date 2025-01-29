function iaguara_attack_state(){
	
	hsp = 0;
	
	if (anim_end()) {
		//jump
		if (image_index < image_number/2) {
			stare();
		}	
		 
		image_index= 0;
		state = iaguara_states.JUMP;
		launch(4.5, 7 );
	}
	
}