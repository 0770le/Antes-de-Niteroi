function tupinamba_anim(){	
	
	sprite_index = sprites_array[state];
	image_xscale = -facing;
	
	
	
	
	show_debug_message("state = " + string(state));
	show_debug_message("number_of_shots = " + string(number_of_shots));
	show_debug_message("can_fire = " + string(can_fire));
	show_debug_message("fire_delay = " + string(fire_delay));
	
}