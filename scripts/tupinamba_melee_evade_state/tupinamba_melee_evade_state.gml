
function tupinamba_melee_evade_state(){

	//caculate movement
	calc_entity_movement(grav*0.9)
	
	//check state
	//change state after touching ground
	if on_ground() {
		//change state
		hsp=0;
		state = tupinamba_melee_states.IDLE;
		image_index = 0;
	}
	


	//apply movement
	collision();
	//apply animations
	anim();

}