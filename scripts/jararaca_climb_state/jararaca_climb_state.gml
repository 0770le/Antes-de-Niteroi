
function jararaca_climb_state(){	
	
	vsp = lerp(vsp, -spd, 0.1);
	hsp = 5*facing;
	
	//apply movement
	collision();

	var step = tilemap_get_at_pixel(global.map,x - 3*facing , bbox_top-1);
	if (step == SOLID) { //voltar no teto
		state = jararaca_states.DESCEND;
		image_index = 0;
		vsp = -vsp;
	} else {
		var _x = side() + 1*facing;
		step = tilemap_get_at_pixel(global.map, side() + 1*facing, bbox_top);
		if (step == VOID) { //fazer curva
			var _pox = find_ground(side() +1*facing, y, -1);
			var t0 = tilemap_get_at_pixel(global.map, side() +1*facing, _pox.y+1);	//1º bloco a frente
			var t1 = tilemap_get_at_pixel(global.map, side() +1*facing + (TILE_SIZE)*facing, _pox.y+1);	//2º bloco a frente
			var t2 = tilemap_get_at_pixel(global.map, side() +1*facing + (TILE_SIZE)*2*facing, _pox.y+1);	//3º bloco a frente
			var t3 = tilemap_get_at_pixel(global.map, side() +1*facing + (TILE_SIZE)*3*facing, _pox.y+1);	//4º bloco a frente
		
			var t0_2 = tilemap_get_at_pixel(global.map, side() +1*facing + (TILE_SIZE)*facing, bbox_top);	//2º bloco a frente
			var t1_2 = tilemap_get_at_pixel(global.map, side() +1*facing + (TILE_SIZE)*2*facing, bbox_top);	//3º bloco a frente
			var t2_2 = tilemap_get_at_pixel(global.map, side() +1*facing + (TILE_SIZE)*3*facing, bbox_top);	//4º bloco a frente
		
			if(t0 == SOLID and t1 == SOLID and t2 == SOLID and t3 == SOLID and (t0_2 == VOID or t0_2 == DEATH) and t1_2 == (VOID or t1_2 == DEATH) and (t2_2 == VOID or t2_2 == DEATH)) {
				state = jararaca_states.STOP_CLIMB;
				image_index = 0;
				var _pos = find_ground( side() +1*facing ,y, -1);
				x = side();
				y = _pos.y;
			} else {
				state = jararaca_states.DESCEND;
				vsp = -vsp;
				image_index = 0;
			}
		} 
	}
	
}


function jararaca_start_climb_state(){
	if(anim_end()) {
		state = jararaca_states.CLIMB;
		image_index = 0;
		y -= 35;
		x = wall_x - facing;
		vsp = -abs(hsp);
		hsp = 0;
	}
}

function jararaca_stop_climb_state(){
	if(anim_end()) {
		state = jararaca_states.MOVING;
		image_index = 0;
		x += 30 * facing;
		hsp = vsp * facing;
		vsp = 0;
	}
}