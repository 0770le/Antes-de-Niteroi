
function iaguara_fall_state(){
	if(hsp_override != 0) {
		hsp = hsp_override;
	}

	//landing
	if (on_ground() and vsp >= 0) {
		hsp_override = 0;
		vsp = 0;
		state = iaguara_states.LANDING;
		image_index = 0;
		//create dust if landing
		if (vsp > 0) {//caiu
			instance_create_layer(x,y, LAYER_EFFECTS, o_player_dust_land);
			//audio_play_sound(snd_landing, 20, false, global.volume);
		}	
	}

	
	
	calc_entity_movement(global.grav,0);
	//apply movement
	collision();
	
}