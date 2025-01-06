function jararaca_moving_state(){
//set mov
	if (on_ground) {
		hsp = lerp(hsp*0.6, gear_spd, spd)*facing;
	}
//change state
	//idle		
	// stop due time
	if (wait_time-- < 0) {
		state = jararaca_states.IDLE;
		wait_time = room_speed * random_range(5, 9);
	} 
	
	//escalar ou voltar .  volta com buraco> 2 e parede < 3  se nao, escala
	
	//buraco
	var next_step = tilemap_get_at_pixel(global.map, side() +1*facing, bbox_bottom + 1);
	//nao cair se buraco > 3 blocos
	var t0 = tilemap_get_at_pixel(global.map, side() +1*facing, bbox_bottom + (TILE_SIZE)+1);	//2º bloco abaixo
	var t1 = tilemap_get_at_pixel(global.map, side() +1*facing, bbox_bottom + (TILE_SIZE)*2+1);	//3º bloco 
	var t2 = tilemap_get_at_pixel(global.map, side() +1*facing, bbox_bottom + (TILE_SIZE)*3+1);	//4º bloco
	
	//parede
	var face = tilemap_get_at_pixel(global.map, side() +1*facing, y);
	////nao subir se parede > 3 blocos 
		var t3 = tilemap_get_at_pixel(global.map, side() +1*facing,  bbox_bottom - (TILE_SIZE*2)-1);	//2º bloco acima
		var t4 = tilemap_get_at_pixel(global.map, side() +1*facing,  bbox_bottom - (TILE_SIZE*2)*2-1);//3º bloco
		var t5 = tilemap_get_at_pixel(global.map, side() +1*facing,  bbox_bottom - (TILE_SIZE*2)*3-1);//4º bloco
	
	
	//hit a wall or an edge
	//if (face == SOLID or next_step == VOID) {
	//	//mt baixo ou mt alto: volta 
	//	if (((t0 == VOID and t1 == VOID and t2 == VOID) or (t3 == SOLID and t4 == SOLID and t5 == SOLID)) or ((t0 == DEATH) or (t1 == DEATH) or (t2 == DEATH))) {
	//		facing*=-1;
	//	} 
	//	//climb  
	//	else if (next_step != VOID) {
	//		start_x = x;
	//		state = jararaca_states.CLIMB;
	//	}
	//}
	
	if(face == SOLID) { // parede
		if(t3 == SOLID and t4 == SOLID and t5 == SOLID) {
			state = jararaca_states.START_CLIMB;
		} else {
			facing = facing * -1;
		}
	} else if (next_step == VOID) { //buraco
		if(t0 == VOID and t1 == VOID and t2 == VOID) {
			state = jararaca_states.START_DESCEND;
		} else {
			facing = facing * -1;
		}
	}

	//apply movement
	collision();
}