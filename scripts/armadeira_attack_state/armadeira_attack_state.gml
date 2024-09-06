///desc "ARMADA"
function armadeira_attack_state() {
	image_index = 0;
	hidden = false;
	//pulou

	if ((distance_to_object(o_player) < alert_distance*0.75) and can_attack) and on_ground() {
			//bote
			hidden=false;
			if can_attack {
				y -= 1;
				launch(4,4)
				can_attack = false;
				attack_cd =  room_speed * random_range(3, 5); 
				alarm[CAN_ATTACK] = attack_cd; 
				if(on_screen(40)) {
					audio_play_sound(snd_frog_jump, 40, false);
				}
			}
			state = armadeira_states.JUMP;
			image_index=0;
			image_speed=1;
			
			
			
		} else if (distance_to_object(o_player) < alert_distance*0.75) and !attack {
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