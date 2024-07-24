
function arqueiro_oculto_hide_state(){
	hidden = true;
	if (distance_to_object(o_player) > alert_distance) {	
		state = enemy_states.IDLE;
		hidden = false;
		fire_delay--;
	}
}


