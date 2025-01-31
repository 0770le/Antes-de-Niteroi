
function frances_reload_state(){
	if anim_end(){
		if(line_of_sight() and abs(y-o_player.y)< 30) {
			state = frances_states.SHOOT;
			image_index = 0;
			can_fire = true;
		} else {
			image_index = 0;
			can_fire = true;
			state = frances_states.RUN;
		}
	}
	
	calc_entity_movement();
	//apply movement
	collision();
	
}