function iaguara_attack_state(){
	
	hsp = lerp(hsp, 0, 0.2);
	
	if (image_index < image_number/2) {
		stare();
	}	
		
	if (anim_end()) {
		//jump
		state = iaguara_states.JUMP;
		image_index= 0;
		
		y-=1;
		//player above
		if(o_player.y < y-TILE_SIZE*4) { //5
			launch(8,2);
		} else {//player under
			launch(4.8,7);
		}
	}
	
}