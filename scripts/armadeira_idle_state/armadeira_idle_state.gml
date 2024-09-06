
function armadeira_idle_state(){
	//change state
	// attack 
	if alert {
		state = armadeira_states.ATTACK;
	}

	// walk  
	if (wait_time-- < 0) {
		facing = choose(-1,1);
		start_x = x;
		patrol_dis = random_range(40, 160);
		state = armadeira_states.WALK;
		wait_time = room_speed * random_range(2, 10);
	} 

//apply movement
	collision();

}
