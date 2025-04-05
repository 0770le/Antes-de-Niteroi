
function jararaca_descend_state(){		
	
	vsp = lerp(vsp, spd, 0.1);
	hsp = 5*facing;
	
	//apply movement
	collision();

	var _step = tilemap_get_at_pixel(global.map, x-facing, bbox_bottom+1);
	if (_step == SOLID or _step == PLATAFORM) {
		
		var t0 = tilemap_get_at_pixel(global.map, x - (TILE_SIZE)*facing, bbox_bottom+1);	//2º bloco a frente
		var t1 = tilemap_get_at_pixel(global.map, x - (TILE_SIZE)*2*facing, bbox_bottom+1);	//3º bloco a frente
		var t2 = tilemap_get_at_pixel(global.map, x - (TILE_SIZE)*3*facing,bbox_bottom+1);	//4º bloco a frente
		
		var t0_2 = tilemap_get_at_pixel(global.map, x - (TILE_SIZE)*facing, bbox_bottom+1-TILE_SIZE);	//1º bloco a frente
		var t1_2 = tilemap_get_at_pixel(global.map, x - (TILE_SIZE)*2*facing, bbox_bottom+1-TILE_SIZE);	//2º bloco a frente
		var t2_2 = tilemap_get_at_pixel(global.map, x - (TILE_SIZE)*3*facing, bbox_bottom+1-TILE_SIZE);	//3º bloco a frente
		var t3_2 = tilemap_get_at_pixel(global.map, x - (TILE_SIZE)*4*facing, bbox_bottom+1-TILE_SIZE);	//4º bloco a frente
		
		if(t0 != VOID and t1 != VOID and t2 != VOID and (t0_2 == VOID or t0_2 == DEATH) and (t1_2 == VOID or t1_2 == DEATH) and (t2_2 == VOID or t2_2 == DEATH) and (t3_2 == VOID or t3_2 == DEATH)) {
			wall_y = bbox_bottom;
			state = jararaca_states.STOP_DESCEND;
			image_index = 0;
		} else {
			state = jararaca_states.CLIMB;
			image_index = 0;
			vsp = -vsp;
		}
	} else {
		_step = tilemap_get_at_pixel(global.map, side() + 1*facing, y);
		if (_step == VOID) {
			state = jararaca_states.CLIMB;
			image_index = 0;
			vsp = -vsp;
		} 
	}
	
}


function jararaca_start_descend_state(){
	if(anim_end()) {
		state = jararaca_states.DESCEND;
		image_index = 0;
		y += 30;
		vsp = abs(hsp);
		hsp = 0;
		facing*=-1
	}
}

function jararaca_stop_descend_state(){
	if(anim_end()) {
		state = jararaca_states.MOVING;
		image_index = 0;
		
		facing*=-1
		
		x = x + 35*facing;
		y = wall_y;
		
		hsp = abs(vsp) * facing;
		vsp = 0;
	}
}