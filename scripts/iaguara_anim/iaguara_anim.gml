function iaguara_anim(){	
	
	sprite_index = sprites_array[state];
	image_xscale = -facing;
	
	switch(state) {
		case iaguara_states.JUMP:
			if (vsp < 0) {
					image_index = 0;
			} else{
					image_index = 1;
			}
			break;
		case iaguara_states.CHASE:
			if( sign(hsp) != sign(facing)) {
				sprite_index = s_iaguara_turn;	
			}
	}
	
}