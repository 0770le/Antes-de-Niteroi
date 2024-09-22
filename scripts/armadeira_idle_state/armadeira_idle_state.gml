
function armadeira_idle_state(){
	
	//change state
	// attack 
	
	if alert {
		state = armadeira_states.ATTACK;
		alert_distance = random_range (45, 64)
		wait_time_initial = room_speed * random_range(3, 5);
	}

	// walk  
	if (wait_time-- < 0) {
		start_x = x;
		facing = choose(-1,1);
		patrol_dis = random_range(40, 160);
		state = armadeira_states.WALK;
		wait_time = room_speed * random_range(2, 10);
		patrol_dis = random_range(patrol_min_dis, patrol_max_dis);
		spd = random_range(spd_min_limit, spd_max_limit);
	} 


	
	//apply movement
	
	collision();
	
}
