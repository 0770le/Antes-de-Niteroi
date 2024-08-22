
function player_hurting_state(){
 
	//get input
	get_input();

	//caculate movement
	calc_entity_movement()
	
	//check state
	//set to first frame and stop if animation has played once
		
	var recover_time = 0.4; //1 = instant recover
	if (anim_end()) {
		if on_ground() {
			state = states.IDLE;
		} else {
			state = states.JUMP;
		}
	}
	
	//apply movement
	collision();
	//check player hp
	check_player_hp();
	//apply animations
	anim();

}