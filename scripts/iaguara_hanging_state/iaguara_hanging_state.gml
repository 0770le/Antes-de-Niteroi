///on wall
function iaguara_hanging_state(){
	
	hsp = 0;
	vsp = 0;
	
	//make dust
	if (!instance_exists(o_player_dust_jump)) {
		evade_dust();
	}

	
	//wall jump 
	if (anim_end()) { 
		x+= 1*facing;
		
		//player abaixo
		if (o_player.bbox_top > bbox_bottom) {
			launch(0,1);
			state= iaguara_states.FALL;
			image_index = 0;
		}
		
		launch(4.5,7);
		state = iaguara_states.JUMP;
		image_index=0;
		audio_play_sound(snd_jump, 15, false, global.volume);
	}

}