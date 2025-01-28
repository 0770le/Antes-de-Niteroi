function iaguara_attack_state(){
	
	hsp = 0;
	
	if (anim_end()) {
			//jump
		var jump_vsp = PLAYER_JUMP_SPEED;
		 
			image_index= 0;
			state = iaguara_states.JUMP;
			launch(jump_vsp, 7 );
	}
	
}