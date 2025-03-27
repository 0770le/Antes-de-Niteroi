
function tupinamba_hurting_state(){
	
	//check state
	//set to first frame and stop if animation has played once
		
	var recover_time = 1; //1 = instant recover
	if (anim_end()) {
		if on_ground() {
			state = tupinamba_states.IDLE;
		} else {
			turret = false;
			state = tupinamba_states.JUMP;
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
	//caculate movement
	calc_entity_movement()
	
}