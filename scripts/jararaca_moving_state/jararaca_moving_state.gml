function jararaca_moving_state(){
//set mov
	if (on_ground) {
		hsp = lerp(hsp, spd*facing, 0.1);
	}
	
	calc_entity_movement();
	
	//apply movement
	collision();
	
	if (idle_move_timer-- <= 0) {
		state = jararaca_states.IDLE;
		idle_move_timer = room_speed * random_range(5, 9);
	} 
	var _x = side();
	var face = tilemap_get_at_pixel(global.map, side() +1*facing, y);
	var next_step = tilemap_get_at_pixel(global.map, side() +1*facing, bbox_bottom + 1);
	
	if(face == SOLID) { // parede
		wall_x =  side() +1*facing;
		
		var t0 = tilemap_get_at_pixel(global.map, side() +1*facing,  bbox_bottom - (TILE_SIZE)-1);	//2º bloco acima
		var t1 = tilemap_get_at_pixel(global.map, side() +1*facing,  bbox_bottom - (TILE_SIZE)*2-1);	//3º bloco acima
		var t2 = tilemap_get_at_pixel(global.map, side() +1*facing,  bbox_bottom - (TILE_SIZE)*3-1);	//4º bloco acima
		
		var t0_2 = tilemap_get_at_pixel(global.map, x,  bbox_bottom - (TILE_SIZE)-1);		//2º bloco diretamente acima
		var t1_2 = tilemap_get_at_pixel(global.map, x,  bbox_bottom - (TILE_SIZE)*2-1);	//3º bloco diretamente acima
		var t2_2 = tilemap_get_at_pixel(global.map, x,  bbox_bottom - (TILE_SIZE)*3-1);	//4º bloco diretamente acima
		
		if(t0 == SOLID and t1 == SOLID and t2 == SOLID and t0_2 == VOID and t1_2 == VOID and t2_2 == VOID) {
			image_index = 0;
			state = jararaca_states.START_CLIMB;
		} else {
			facing = facing * -1;
		}
	} else if (next_step == VOID) { //buraco
		
		var t0 = tilemap_get_at_pixel(global.map, side() +1*facing, bbox_bottom + (TILE_SIZE)+1);	//2º bloco abaixo
		var t1 = tilemap_get_at_pixel(global.map, side() +1*facing, bbox_bottom + (TILE_SIZE)*2+1);	//3º bloco abaixo
		var t2 = tilemap_get_at_pixel(global.map, side() +1*facing, bbox_bottom + (TILE_SIZE)*3+1);	//4º bloco abaixo
		
		var t0_2 = tilemap_get_at_pixel(global.map, side() -2*facing,  bbox_bottom + (TILE_SIZE)+1);		//2º bloco diretamente abaixo
		var t1_2 = tilemap_get_at_pixel(global.map, side() -2*facing,  bbox_bottom + (TILE_SIZE)*2+1);	//3º bloco diretamente abaixo
		var t2_2 = tilemap_get_at_pixel(global.map, side() -2*facing,  bbox_bottom + (TILE_SIZE)*3+1);	//4º bloco diretamente abaixo
		
		if(t0 == VOID and t1 == VOID and t2 == VOID and t0_2 == SOLID and t1_2 == SOLID and t2_2 == SOLID) {
			state = jararaca_states.START_DESCEND;
			image_index = 0;
			var _pos = find_ground( side() +1*facing ,y, -1);
			x = side();
			y = _pos.y;
		} else {
			facing = facing * -1;
		}
	}
}