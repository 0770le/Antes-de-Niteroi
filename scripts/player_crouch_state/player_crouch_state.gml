
function player_crouch_state(){
	//get input
	get_input();
	
	//calculate movement
	calc_movement();
	
	//check state
	if down {
		state = states.CROUCH;
		hsp=0;
	} else {
		state = states.IDLE;
	}
		
	if (alarm[HIDING] == 0) {
		hide_check() 
	} 
	
	if (hsp != 0) {
		state = states.WALK;
	}
	
	if attack {
		state = states.ATTACK;
		image_index = 0;
	}
	
	if jump {
		jumped();
	}
	
	if shoot {
		state = states.SHOOT;
		image_index = 0;
	}
	
	if evade {
		state = states.EVADE;
		image_index = 0;
	} 
	
	//apply movement
	collision();
	//check player hp
	check_player_hp();
	//aply animation
	anim();
}
