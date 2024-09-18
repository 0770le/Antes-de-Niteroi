
function tupinamba_shoot_state() {
	
	//fire 
	if number_of_shots >= 1 and floor(image_index) == 6 and !runned_once {
		create_arrow()
	} 
		
	//repeating shots
	if number_of_shots >= 1 and image_index >= 13 {
		image_index = 3;
	}	
	
	//finish firing
	if anim_end() { 
		can_fire = true;
		fire_delay = 10;//fire_delay_initial;
		number_of_shots = number_of_shots_initial;
		state = tupinamba_states.IDLE; 
		image_index =0;
	}				
	
	//check state
	
	//not in range
	if (distance_to_object(o_player) > alert_distance) {
		state = tupinamba_states.IDLE;
		image_index =0;
	}
	
	collision();
}