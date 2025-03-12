
function tupinamba_shoot_state() {
	
	stare();

	//paradinha
	var _pause = random_range(0.5,0.8);
	if (floor(image_index) == 3) and !runned_once {	
		runned_once = true;
		alarm[ONCE] = _pause* room_speed;
		anim_paused(_pause);
		
	}

	//fire in right image
	if (can_fire and number_of_shots >= 1 and image_index >= 5) {
		can_fire = false;

		create_arrow();
		//shot round		
		number_of_shots -= choose(1,2,3);	
	}
	 
		
	//repeating shots
	if (number_of_shots >= 1 and image_index > 9) {
		image_index = 1;
		can_fire = true;
	}
	
	if (anim_end()) { 
		number_of_shots = number_of_shots_initial;
		can_attack = false;
		alarm[CAN_ATTACK] = room_speed * random_range(3,5);
		state = tupinamba_states.IDLE; 
		wait_time = random_range(1, 2) * room_speed;
		image_index =0;
	}
	
	calc_entity_movement();
	collision();
}