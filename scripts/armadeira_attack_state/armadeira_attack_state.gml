///desc "ARMADA"
function armadeira_attack_state() {
	//image_index = 0;
	image_speed =1;


	
	if ((distance_to_object(o_player) < alert_distance*0.8)) and on_ground() {
	//CHASE
		if can_attack {
			can_attack = false;
			//chase CD
			alarm[CAN_ATTACK] = room_speed * random_range(1.5, 2);
			start_x = x;
			state = armadeira_states.CHASE;
		}
		
	//ARMADA
	} else { 
		if on_ground() {
		hsp = 0;
		image_index=0;
		}
		//go agressive if player dont leave 
		if agressive_timer > 0 {
			agressive_timer --;
		} else {
			y-=2;
			launch(1.8,1.8);
			agressive_timer = room_speed * random_range(1.5, 2);
		}	
	}	
		
	if !alert {
		alarm[HIDING] = hide_delay;
		state = armadeira_states.IDLE;
	}

	

	//apply movement
		collision();

}




