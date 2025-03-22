
function iaguara_sleep_state() {
	
	calc_entity_movement(global.grav, 0.3);
	collision();
	
	if(distance_to_object(o_player) < attack_range*2) {
		state = iaguara_states.LANDING;	
	}
	
}

