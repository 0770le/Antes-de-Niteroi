///standar jump off the ground
function jumped() {
	if (on_ground()) {
		if (o_game.has_cloak) {
			jumps = jumps_initial + 1;
		}else {
			jumps = jumps_initial;
		}
	}
	
	
	
	//jumping
	if (jumps > 0) {
		scale_x = scale_min;
		scale_y = scale_max;
		vsp_decimal = 0;
		state = states.JUMP;
		vsp = jump_spd;
		jumps -= 1;
		evade_dust();
		audio_play_sound(snd_jump, 15, false);
	}	
	
	
}
