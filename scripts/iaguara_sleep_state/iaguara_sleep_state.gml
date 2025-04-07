
function iaguara_sleep_state() {
	
	
	layer = layer_get_id(LAYER_MESSAGES);
	
	calc_entity_movement(global.grav, 0.3);
	collision();
	
	if(distance_to_object(o_player) < alert_distance) {
		state = iaguara_states.LANDING;	
	}
	
}

