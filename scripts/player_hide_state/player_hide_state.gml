
function player_hide_state(){
	//get input
	get_input();
	//caculate movement
	calc_movement();
	
	//stealth
	hidden = true;

	//check states
	if (hsp != 0) {
		state = states.WALK;
	}

	if (attack and can_attack){
		state =	states.ATTACK;
		image_index = 0;
		can_attack = false;
		alarm[ATTACKING]= attack_delay;
	}
	
	if jump {
		jumped();		
	}
	
	//if shoot {
	//	state= states.SHOOT;
	//	hsp = 0;
	//	image_index =0;
	//}
	
	if evade {
		state=states.EVADE;
		image_index = 0;
	}
		
	if down and !jump {
		state = states.HIDE;
		hsp=0;
	}
	
	if up {
		state = states.IDLE;
	}
	
	//break stealth if out of hide state
	if (state != states.HIDE) {
		hidden = false;
	}
	
	//apply movement
	collision();
	//check player hp
	check_player_hp();
	//apply animations
	anim();

}
