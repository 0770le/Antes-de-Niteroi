
function jararaca_idle_state(){
	//smooth stop
	hsp = lerp(hsp, 0, 0.3)*facing;
	
	//change state move due time
	if (idle_move_timer-- <= 0 ) {
		
		state = jararaca_states.MOVING;
		idle_move_timer = room_speed * random_range(5, 9);
		
		var _gear_spd = choose(1,2,3);
		spd = spd_array[_gear_spd];
		image_speed = img_spd_array[_gear_spd];
	} 

	//apply movement
	calc_entity_movement();
	collision();
	
}
