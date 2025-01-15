
function chevalier_hurting_state(){
	
	//check state
	//set to first frame and stop if animation has played once
		
	var recover_time = 0.5; //1 = instant recover
	if (anim_end()) {
			state = chevalier_states.IDLE;
	}
	
		//making drag dust
	if on_ground and hsp != 0 {
		if !runned_once {
			runned_once = true;
			alarm[ONCE] = 0.08*room_speed;
			jump_dust()//faz o objeto dust_evade
		}
	}
	
	//knockback in player o_hitbox**
	
//physics
	calc_entity_movement();
	collision();
	
	
}