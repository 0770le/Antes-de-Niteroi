event_inherited();


show_debug_message("state = " + string(state));

if (!on_ground() and (hsp < 0) and (state != iaguara_states.JUMP) ) {
	state = iaguara_states.FALL;
	image_index = 0;
}

if ((sign(facing) != sign(hsp)) and on_ground() and hsp != 0){
	if !runned_once {
			runned_once = true;
			alarm[ONCE] = 0.1*room_speed;
			jump_dust()//faz o objeto dust_evade
		}
}

descend();

//mask_index = mask_array[state];
