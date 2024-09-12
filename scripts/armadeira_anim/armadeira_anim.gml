function armadeira_anim(){	
	
	if state == armadeira_states.JUMP and vsp > 0 {
		sprite_array[armadeira_states.JUMP] = s_armadeira_fall;
	} else {
		sprite_array[armadeira_states.JUMP] = s_armadeira_jump;
	}
	
	sprite_index = sprites_array[state];
	image_xscale = -facing;
	
	
}