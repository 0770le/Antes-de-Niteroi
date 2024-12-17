
function frances_jump_state(){
	
	//moving
	hsp = spd * facing;
	x += hsp;
	//check state
	//landing
	if on_ground() {
		state = frances_states.PATROL;
		image_index = 0;
		image_speed = 1;
		//create dust if landing
		if (vsp > 0) {
			instance_create_layer(x,y, LAYER_EFFECTS, o_player_dust_land);
			audio_play_sound(snd_landing, 20, false, global.volume);
		}	
	}

	
	calc_entity_movement();
	//apply movement
	collision();
	
}