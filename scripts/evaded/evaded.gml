///standar evade leap off the ground
function evaded() {
	if ((jumps > 0) or (on_ground()) and has_evade) {
		scale_x = scale_min;
		scale_y = scale_max;
		vsp_decimal = 0;
		hsp_decimal = 0;
		state = states.EVADE;
		vsp = evade_v_spd;
		hsp = evade_h_spd*-facing;
		jumps--;
		has_evade = false;
		alarm[EVADING] = room_speed * evade_delay;
		untargetable = true;
		
		//making dust contraria
		jump_dust();
		
		audio_play_sound(snd_jump, 15, false);
	}	
}