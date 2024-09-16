
function tupinamba_shoot_state() {
	stare();
	//player na frente
	if line_of_sight() {
		if (fire_delay <= 0) {
			tupinamba_shoot();
		} 
	}
	
	if (distance_to_object(o_player) > alert_distance) {
			state = tupinamba_states.IDLE;
	} 
}