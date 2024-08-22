
function jararaca_idle_state(){
	//change state
	
	// move if player is too close 
	if ((distance_to_object(o_player) < alert_distance) and can_attack) {
			can_attack = false;
			alarm[CAN_ATTACK] = attack_cd;// emprestado como CD
			state = jararaca_states.MOVING;
	}
	
	// move due time
	if (wait_time-- < 0 ) {
		state = jararaca_states.MOVING;
		wait_time = room_speed * random_range(5, 9);
		gear_spd = spd_array[choose(1,2,3)];
	} 

	//apply movement
	collision();
	
}
