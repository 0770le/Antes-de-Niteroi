
function tupinamba_melee_jump_state(){
	
	//moving
	hsp = spd * facing;
	x += hsp;
	//check state
	//landing
	if on_ground() {
		state = tupinamba_melee_states.PATROL;
		image_index = 0;
		image_speed = 1;
		//create dust if landing
		if (vsp > 0) {//caiu
			instance_create_layer(x,y, "Dust", o_player_dust_land);
			audio_play_sound(snd_landing, 20, false, global.volume);
		}	
	}

	//tocando a parede no ar
	var face = tilemap_get_at_pixel(global.map, side() +1*facing, y-1);
	
	if (face == SOLID) and (vsp > 0.24) { // vsp caindo q entra no sliding
			wait_time = room_speed * 0.4;
			state = tupinamba_melee_states.HANGING;
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