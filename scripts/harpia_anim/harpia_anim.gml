function harpia_anim(){
	
	if(state == harpia_states.CHASE) {
		image_xscale = -facing;
		image_speed = 1;
		if(sign(facing) == dir) {
			sprite_index = s_harpia_move_forward;
		} else {
			sprite_index = s_harpia_move_back;
		}
	} else if(state == harpia_states.ATTACK) {
		if(attack_prepare_timer > 0) {
			sprite_index = s_harpia_move_back;
		} else {
			sprite_index = s_harpia_attack;	
		}
	} else {
		sprite_index = sprites_array[state];
	}
}