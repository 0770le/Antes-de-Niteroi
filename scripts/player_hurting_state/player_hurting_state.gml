
function player_hurting_state(){

	//caculate movement
	calc_entity_movement()
	
	//in case that image_speed was stoped.
	image_speed = 1;
		
	var recover_time = 1; //1 = instant recover
	if (anim_end()) {
		if on_ground() {
			state = states.IDLE;
		} else {
			state = states.JUMP;
		}
	}
	
		//making drag dust
	if on_ground and hsp != 0 {
		if !runned_once {
			runned_once = true;
			alarm[ONCE] = 0.1*room_speed;
			jump_dust()//faz o objeto dust_evade
		}
	}
	//apply movement
	collision();
	//check player hp
	check_player_hp();
	//apply animations
	anim();

}