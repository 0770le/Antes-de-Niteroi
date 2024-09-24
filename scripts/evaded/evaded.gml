///standar evade leap off the ground
function evaded() {
	if ((jumps > 0) or (on_ground()) and has_evade) {
		image_index = 0;
		image_speed = 1;
		scale_x = scale_min;
		scale_y = scale_max;
		vsp_decimal = 0;
		hsp_decimal = 0;
		state = states.EVADE;
		
		//making dust contraria
		jump_dust();
		audio_play_sound(snd_jump, 15, false, global.volume);
		
		jumps--;
		has_evade = false;
		alarm[EVADING] = room_speed * evade_delay;
		untargetable = true;
		
		//allow 'rooted' evade
		if down {
			launch( (jump_spd*0.3) , 2 , -1*facing );
		}else {
			launch( (jump_spd*0.3) , max_hsp*4 , -1*facing );
			
		}
	}	
}