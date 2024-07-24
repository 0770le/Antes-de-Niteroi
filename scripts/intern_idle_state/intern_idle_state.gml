
function intern_idle_state(){
	//check health
	check_enemy_hp();
	
	//caculate movement
	calc_entity_movement();
	
	//modify state
	
	if alert {
		state = intern_states.ALERTED;
	}
	
	//apply movement
	collision();

	
}