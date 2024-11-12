
function frances_reload_state(){
	if anim_end(){
		state = frances_states.SHOOT;
		image_index = 0;
		image_speed = 1;
		can_fire = true;
	}
	
}