///collision();
function collision() {
	//apply carried over decimals
	hsp += hsp_decimal;
	vsp += vsp_decimal;
	
	//floor decimals
	//save and subtracting decimals (making sure collisions use hole numbers)
	hsp_decimal = hsp - (floor(abs(hsp)) * sign(hsp));
	hsp -= hsp_decimal;
	vsp_decimal = vsp - (floor(abs(vsp)) * sign(vsp));
	vsp -= vsp_decimal;
	
	//horizontal collision
	var _side;
	//determine wich side to test
	if (hsp > 0) {
		_side = bbox_right;
	} else {
		_side = bbox_left;
	}

	//check top and bottom of side
	var t1 = tilemap_get_at_pixel(global.map, _side + hsp, bbox_top);
	var t2 = tilemap_get_at_pixel(global.map, _side + hsp, bbox_bottom);	

	if ((t1 != VOID) and (t1 != PLATAFORM )) or
	   ((t2 != VOID) and (t2 != PLATAFORM)) {
		//collision found
		//indo para a direita
		if (hsp > 0) {
			x = _side - (_side mod global.tile_size) + global.tile_size - 1 - (_side - x);	
		//esquerda
		}else{
			x = _side - (_side mod global.tile_size) + (x - _side);
		}
		hsp = 0;
	}
	x+= hsp;
	
	//verificando se entrou no chao por seguranca
	t1 = tilemap_get_at_pixel(global.map, bbox_right, bbox_top);
	t2 = tilemap_get_at_pixel(global.map, bbox_right, bbox_bottom);
	if(t1 == SOLID or t2 == SOLID) {
		x = x - (x mod global.tile_size) + global.tile_size - 1 - (bbox_right - x);
	}
	
	
	//VERTICAl collision
	var vertical_side;
	//determine wich side to test
	if (vsp > 0) {
		vertical_side = bbox_bottom; 
	}else{ 
		vertical_side = bbox_top;
	}
	
	//check left and right of bottom side
	var vt1 = tilemap_get_at_pixel(global.map,bbox_left, vertical_side + vsp);
	var vt2 = tilemap_get_at_pixel(global.map,bbox_right, vertical_side + vsp);
	
	var vt3 = tilemap_get_at_pixel(global.map, bbox_left, vertical_side);
	var vt4 = tilemap_get_at_pixel(global.map, bbox_right, vertical_side);

	//collision found
	if (vt1 != VOID and (((vsp > 0 or vt1 != PLATAFORM)) and vt3 != PLATAFORM) or (vt1 == SOLID and vt3 == PLATAFORM)) or
	   (vt2 != VOID and (((vsp > 0 or vt2 != PLATAFORM)) and vt4 != PLATAFORM) or  (vt2 == SOLID and vt4 == PLATAFORM)) {
		
		//floor
		if (vsp > 0) {
			y = (bbox_bottom+vsp) - ((bbox_bottom+vsp) mod global.tile_size) - 1 - (bbox_bottom - y);
		} else { 
		//ceiling
			//var y1 = bbox_top - (bbox_top mod global.tile_size);
			//y = y1 + (bbox_bottom - bbox_top);
			
			var _diff = (vsp + bbox_top) mod global.tile_size;
			var _diff2 = global.tile_size - _diff;
			
			var y1 = bbox_top + vsp + _diff2;
			y = y1 + (y - bbox_top);
		}
		vsp = 0;
		//death tile check
		if (((vt1 == DEATH) or (vt2 == DEATH)) or (y > room_height)) {
			hp = 0;
		}
	}
	
	y+= vsp;
	
}