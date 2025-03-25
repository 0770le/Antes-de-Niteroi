///on wall
function iaguara_hanging_state(){
	
	hsp = 0;
	vsp = 0;
	
	var _wall = true;
	while(_wall){
		var _tile  = tilemap_get_at_pixel(global.map, side(false)-facing, y);
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
	
		x += facing * 20; //20
		
		//player abaixo
		if ((o_player.bbox_top > bbox_bottom + 4) and (point_distance(x, y, o_player.x, o_player.y) < attack_range*2)) {
		
		launch(2,3);
			state= iaguara_states.FALL;
			image_index = 0;
		//acima	
		} else if(o_player.y < y-TILE_SIZE*5) {
			
			launch(8,3);
			state = iaguara_states.JUMP;
			sprite_index = sprites_array[iaguara_states.JUMP];
			mask_index = mask_array[iaguara_states.JUMP];
			image_index=0;
		} else {		
			
			launch(4.5,7);
			state = iaguara_states.JUMP;
			sprite_index = sprites_array[iaguara_states.JUMP];
			mask_index = mask_array[iaguara_states.JUMP];
			image_index=0;
	
		}
		
		
		
		audio_play_sound(snd_jump, 15, false, global.volume);
	}

}