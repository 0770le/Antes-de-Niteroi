
function frances_run_state() {
	stare();
	if(line_of_sight() and abs(y-o_player.y)< 30){
		if !can_fire {
			state = frances_states.RELOAD;
			image_index = 0;
				
		//fire	
		} else { 
			state = frances_states.SHOOT;
			image_index = 0;
		}
	} else {
		if(abs(o_player.x - x) < 200) {
			facing = -facing;
			hsp = facing*spd*5;
		} else {
			state = frances_states.IDLE;
		}
	}
	
	calc_entity_movement();
	collision();
}