
function player_air_attack_end_state(){

	//get input
	get_input();

	//caculate movement
	calc_entity_movement(global.grav*0.9)
	
	//check state
	//change state after touching ground
	if on_ground() {
		//change state
		hsp=0;
		state = states.IDLE;
		//can_take_dmg = true;
	}
	
	//apply movement
	collision();
	//check player hp
	check_player_hp();
	//apply animations
	anim();

}