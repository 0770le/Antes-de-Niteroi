
function frances_shoot_state() {
	
	stare();

	//fire in right image
	if floor(image_index) == 7 and !runned_once {
		create_bullet()
		//smoke
		var inst = instance_create_layer (side()+11*facing, y - 20, "Arrow_shoot", o_frances_fumaca);			
		inst.image_xscale = facing*-1;
	} 
		
	
	//finish firing
	if anim_end() { 
		can_fire = false;
		fire_delay = fire_delay_initial;
		

		state = frances_states.IDLE; 
			//before patrol
		wait_time = random_range(1, 2) * room_speed;
		image_index =0;
	}				
	
	calc_entity_movement();
	collision();
}