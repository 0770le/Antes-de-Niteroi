
function tupinamba_jump_state(){
	
	//moving
	hsp = spd * facing;
	x += hsp;
	//check state
	//landing
	if on_ground() {
		state = tupinamba_states.PATROL;
		image_index = 0;
		//create dust if landing
		if (vsp > 0) {
			instance_create_layer(x,y, LAYER_EFFECTS, o_player_dust_land);
			audio_play_sound(snd_landing, 20, false, global.volume);
		}	
	}

	//tocando a parede no ar
	var face = tilemap_get_at_pixel(global.map, side() +1*facing, y-1);
	
	if (face == SOLID) and (vsp > 0.24) { // vsp caindo q entra no sliding
			state = tupinamba_states.HANGING;
			//pro começo do arrastar nao ficar truncado
			vsp += 1; 
	}

	//change direction if hit ceiling
	var _hoof = tilemap_get_at_pixel(global.map, x, bbox_top -1);
	
	if _hoof == SOLID {
		patrol_destination *=-1;
		facing *= -1;
		state= tupinamba_states.JUMP;
	}
	
	calc_entity_movement();
	//apply movement
	collision();
	
}