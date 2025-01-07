
function player_evade_state(){

	calc_entity_movement(global.grav*0.9)

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