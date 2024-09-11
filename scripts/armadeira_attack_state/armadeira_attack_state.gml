///desc "ARMADA"
function armadeira_attack_state() {
	//image_index = 0;
	hidden = false;
	

	//if ((distance_to_object(o_player) < alert_distance*0.5) and can_attack) and on_ground() {
	//		//JUMP
	//		hidden=false;
	//		if can_attack {
	//			y -= 1;
				
	//			launch(random_range(4,2), random_range(6,3));
	//			can_attack = false;
	//			attack_cd =  room_speed * random_range(3, 5); 
	//			alarm[CAN_ATTACK] = attack_cd; 
	//			if(on_screen(40)) {
	//				audio_play_sound(snd_frog_jump, 40, false);
	//			}
	//		}
	//		state = armadeira_states.JUMP;
	//		image_index=0;
	//		image_speed=1;
			
				
	//	} else if (distance_to_object(o_player) < alert_distance*0.70) and !attack  {
	//		//chase
	//		attack = true;
	//		wait_time_initial = room_speed * random_range(1, 3);
	//		alarm[ATTACKING] = wait_time_initial; 
	//		start_x = x;
	//		state = armadeira_states.CHASE;
	//	} else { //parada
	//		if (on_ground()) {
	//			hsp = 0;
	//			image_index=0;
	//		}
	//	}	
		
	//if !alert {
	//	alarm[HIDING] = hide_delay;
	//	state = armadeira_states.IDLE;
	//}
	
	
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




