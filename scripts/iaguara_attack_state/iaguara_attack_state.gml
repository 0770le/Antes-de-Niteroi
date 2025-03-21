function iaguara_attack_state(){
	
	hsp = lerp(hsp, 0, 0.2);
	
	if (image_index < image_number/2) {
		stare();
	}	
		
	if (anim_end()) {
		//jump
		state = iaguara_states.JUMP;
		image_index= 0;
		if(o_player.y < y-TILE_SIZE*5) {
			launch(8,2);
		} else {
			launch(5,7);
		}
	}
	
}