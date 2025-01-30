event_inherited();

if (!on_ground() and (vsp > 0) and (state != iaguara_states.JUMP) ) {
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
