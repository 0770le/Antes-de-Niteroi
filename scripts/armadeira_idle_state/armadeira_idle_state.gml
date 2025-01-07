
function armadeira_idle_state(){
	
	//change state
	// attack 
	
	hsp =0;
	
	if alert {
		state = armadeira_states.ATTACK;
		alert_distance = random_range (45, 64)
		agressive_timer = room_speed * random_range(1.5, 3);
	} else {
		// walk  
		if (wait_time-- < 0) {
			wait_time= wait_time_initial;
			start_x = x;
			facing = choose(-1,1);
			patrol_dis = random_range(40, 160);
			state = armadeira_states.WALK;
			patrol_dis = random_range(patrol_min_dis, patrol_max_dis);
			spd = random_range(spd_min_limit, spd_max_limit);
		} 
		
	}

	if !on_screen(60) {
		state = armadeira_states.OUT_OF_SCREEN;
	}
	
	//apply movement
	calc_entity_movement();
	collision();
	
}
