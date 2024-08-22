
function player_idle_state(){
 
	//get input
	get_input();

	//caculate movement
	calc_movement();
	
	//check state
	if hsp != 0 state = states.WALK;

	if attack{
		state = states.ATTACK;
		image_index =0;
	}
	
	if( !on_ground()) {
		state = states.JUMP;
	}
	
	if jump {
		jumped();
	}
	
	if evade {
		evaded();
		image_index = 0;
	}
	
	if shoot {
		state = states.SHOOT;
		image_index = 0;
	}
	
	if down {
		crouched();
	}
	
	
	//apply movement
	collision();

	//check player hp
	check_player_hp();
	
	//apply animations
	anim();

}