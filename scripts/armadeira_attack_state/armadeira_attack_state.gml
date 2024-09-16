///desc "ARMADA"
function armadeira_attack_state() {
	//image_index = 0;
	image_speed =1;
	hidden = false;

	
	if ((distance_to_object(o_player) < alert_distance*0.7)) and on_ground() {
	//CHASE
		if can_attack {
			can_attack = false;
			wait_time_initial = room_speed * random_range(1.5, 3);
			alarm[CAN_ATTACK] = wait_time_initial; 
			start_x = x;
			state = armadeira_states.CHASE;
		}
		
	//ARMADA
	} else { 
		if on_ground() {
		hsp = 0;
		image_index=0;
		}
	}	
		
	if !alert {
		alarm[HIDING] = hide_delay;
		state = armadeira_states.IDLE;
	}


	//apply movement
		collision();

}




