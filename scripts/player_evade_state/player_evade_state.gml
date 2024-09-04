
function player_evade_state(){

	//get input
	get_input();

	//caculate movement
	//calc_movement();
	calc_entity_movement()
	
	//check state
	//change state after touching ground
	if on_ground() {
		//change state
		hsp=0;
		state = states.IDLE;
		can_take_dmg = true;
	}
	
	//apply movement
	collision();
	//check player hp
	check_player_hp();
	//apply animations
	anim();

}