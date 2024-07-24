
function intern_alerted_state() {
	
	
	//modify state
	if (!alert) { 
		state = states_idle;
	}
	
	//apply movement
	collision();

}