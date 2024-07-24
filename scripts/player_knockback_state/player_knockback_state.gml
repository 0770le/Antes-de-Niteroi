
function player_knockback_state(){
 
	//get input
	get_input();

	calc_entity_movement();
	//stop
	if abs(hsp) <=0.5 hsp=0;
		
	//check state
	//change state after animation
	if (((image_index) >= (image_number - image_speed)) and ((hsp) == 0)) {
		//change state
		state = states.IDLE;
	}
	
	//apply movement
	collision();
	//check player hp
	check_player_hp();
	//apply animations
	anim();

}