
if instance_exists(o_player) {
	if (distance_to_object(o_player) < 60) {
		//state = passaro_states.FLYING;
		state = "flying";
		
		//fly away from player
		if (x > o_player.x) {
			facing = 1;
		} else {
			facing = -1;
		}
	}
}

if state == "idle" {
	passaro_idle();
} else {
	passaro_flying();
}
	
