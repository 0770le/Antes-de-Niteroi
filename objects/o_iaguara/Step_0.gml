event_inherited();

descend();



if (!on_ground() and (hsp < 0) ) {
	state = iaguara_states.FALL;
	image_index = 0;
}

if ((sign(facing) != sign(hsp)) and on_ground() and hsp != 0){
	if !runned_once {
			runned_once = true;
			alarm[ONCE] = 0.08*room_speed;
			jump_dust()//faz o objeto dust_evade
		}
}

//mask_index = mask_array[state];
