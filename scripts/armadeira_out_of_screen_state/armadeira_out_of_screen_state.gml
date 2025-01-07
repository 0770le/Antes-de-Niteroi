
function armadeira_out_of_screen_state(){
	
	hidden= true;
	
	if on_screen(60){
		state = armadeira_states.IDLE;
		wait_time= wait_time_initial;
	}
	

	
	//apply movement
	calc_entity_movement();
	collision();
	
}
