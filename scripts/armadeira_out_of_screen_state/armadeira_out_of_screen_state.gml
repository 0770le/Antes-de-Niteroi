
function armadeira_out_of_screen_state(){
	
	hidden= true;
	
	if on_screen(0){
		state = armadeira_states.IDLE;
		wait_time= wait_time_initial;
	}
}
