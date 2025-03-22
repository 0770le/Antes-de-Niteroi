///on wall
function iaguara_hanging_state(){
	
	hsp = 0;
	vsp = 0;
	
	var _wall = true;
	while(_wall){
		var _tile  = tilemap_get_at_pixel(global.map, side(false)-facing, y-sprite_height/2);
		_wall = _tile != SOLID;
		if(_wall) {
			x -= facing;
		}
	}	
	
	//make dust
	if (!instance_exists(o_player_dust_jump)) {
		evade_dust();
	}

	
	//wall jump 
	if (anim_end()) { 
		x+= 1*facing;
		
		//player abaixo
		if (o_player.bbox_top > bbox_bottom + 42) {
			launch(0,1);
			state= iaguara_states.FALL;
			image_index = 0;
		}
		
		launch(4.5,7);
		state = iaguara_states.JUMP;
		sprite_index = sprites_array[iaguara_states.JUMP];
		mask_index = mask_array[iaguara_states.JUMP];
		
		x += facing * 20;
		
		image_index=0;
		audio_play_sound(snd_jump, 15, false, global.volume);
	}

}