function jararaca_anim(){	
	
	if (licking) { //sprite lingua
		sprites_array[jararaca_states.IDLE]		=	s_jararaca_tongue_idle;
		sprites_array[jararaca_states.MOVING]	=	s_jararaca_tongue_moving;
	} else { //sprite sem lingua
		sprites_array[jararaca_states.IDLE]		 =	s_jararaca_idle;
		sprites_array[jararaca_states.MOVING]	 =	s_jararaca_moving;
	}
	
	sprite_index = sprites_array[state];
//	mask_index = mask_array[state];
	image_xscale = -facing;
	image_speed=1;
}