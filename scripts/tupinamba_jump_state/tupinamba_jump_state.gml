
function tupinamba_jump_state(){
	
	//moving
	hsp = spd * facing;
	
	//landing
	if on_ground() {
		state = tupinamba_states.PATROL;
		image_index = 0;
		//create dust if landing
		if (vsp > 0) {//caiu
			instance_create_layer(x,y, LAYER_EFFECTS, o_player_dust_land);
			//audio_play_sound(snd_landing, 20, false, global.volume);
		}	
	}

	//tocando a parede no ar
	var face = tilemap_get_at_pixel(global.map, side() +2*facing, y-1);
	
	if (face == SOLID) {
		var roof = tilemap_get_at_pixel(global.map, x, bbox_top -4)
		if (roof == SOLID) { // muda de lado
			patrol_destination *=-1;
			facing *= -1;
			hsp = spd * facing;
		} else if (vsp > 0.34) { // vsp caindo q entra no sliding
			hanging_time = hanging_time_initial;
			state = tupinamba_states.HANGING;
			//pro começo do arrastar nao ficar truncado
			vsp = 0; 
		}
	}
	
	calc_entity_movement();
	//apply movement
	collision();
	
}