function tupinamba_melee_anim(){	
	
	sprite_index = sprites_array[state];
	image_xscale = -facing;
	
	
	
	//it uses imgase_speed 0 in attack
	if sign(hsp) != 0 and sign(hsp) != facing {
		image_speed = -1;
	}
	if sign(hsp) != 0 and sign(hsp) == facing {
		image_speed = 1;
	}
}