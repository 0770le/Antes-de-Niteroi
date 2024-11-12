
function frances_duck_state(){
	if (anim_end() ) {
		image_index = image_number - 1;
		image_speed = 0;	
	}
	
	if (duck_time-- <= 0) {
		duck_time = duck_time_initial;
		state = frances_states.IDLE;
		image_index = 0;
		image_speed = 1;
	}
	
	
	
}