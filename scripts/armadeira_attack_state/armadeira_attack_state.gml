///desc "ARMADA"
function armadeira_attack_state() {
	image_index = 0;
	hidden = false;
	//pulou
	if ((distance_to_object(o_player) < alert_distance*0.75) and can_attack) {
			//bote
			state = armadeira_states.JUMP;
			image_index=0;
			image_speed=1;
		} else if (distance_to_object(o_player) < alert_distance/2) and !attack {
			//chase
			attack = true;
			alarm[ATTACKING] = wait_time_initial * 0.6; 
			start_x = x;
			state = armadeira_states.CHASE;
		} else { //parada
			if (on_ground()) {
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