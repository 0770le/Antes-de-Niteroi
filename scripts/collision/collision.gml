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
		if (hsp > 0) {
			x = x - (x mod global.tile_size) + global.tile_size - 1 - (_side - x);
		}else{
			x = x - (x mod global.tile_size) - (_side - x);
		}
		hsp = 0;
	}
	x+= hsp;
	
	//VERTICAl collision
	var vertical_side;
	//determine wich side to test
	if (vsp > 0) {
		vertical_side = bbox_bottom; 
	}else{ 
		vertical_side = bbox_top;
	}
	
	//check left and right of side
	var vt1 = tilemap_get_at_pixel(global.map,bbox_left, vertical_side + vsp);
	var vt2 = tilemap_get_at_pixel(global.map,bbox_right, vertical_side + vsp);
	
	var vt3 = tilemap_get_at_pixel(global.map, bbox_left, bbox_bottom);
	var vt4 = tilemap_get_at_pixel(global.map, bbox_right, bbox_bottom);

	if (vt1 != VOID and (((vsp > 0 or vt1 != PLATAFORM)) and vt3 != PLATAFORM) or (vt1 == SOLID and t3 == PLATAFORM)) or
	   (vt2 != VOID and (((vsp > 0 or vt2 != PLATAFORM)) and vt4 != PLATAFORM) or  (vt2 == SOLID and t4 == PLATAFORM)) {
	
		//collision found
		if (vsp > 0) {
			y = y - (y mod global.tile_size) + global.tile_size - 1 - (vertical_side - y);
		} else { 
			y = y - (y mod global.tile_size) - (vertical_side - y);
		}
		vsp = 0;
		//death tile check
		if (((vt1 == DEATH) or (vt2 == DEATH)) or (y > room_height)) {
			hp = 0;
		}
	}
	y+= vsp;
	
}