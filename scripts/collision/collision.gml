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
	
	//vertical collision
	var _side;
	//determine wich side to test
	if vsp > 0 _side = bbox_bottom else _side = bbox_top;
	
	//check left and right of side
	var t1 = tilemap_get_at_pixel(global.map,bbox_left, _side + vsp);
	var t2 = tilemap_get_at_pixel(global.map,bbox_right, _side + vsp);
	
	var t3 = tilemap_get_at_pixel(global.map, bbox_left, bbox_bottom);
	var t4 = tilemap_get_at_pixel(global.map, bbox_right, bbox_bottom);

	if (t1 != VOID and (((vsp > 0 or t1 != PLATAFORM)) and t3 != PLATAFORM) or (t1 == SOLID and t3 == PLATAFORM)) or
	   (t2 != VOID and (((vsp > 0 or t2 != PLATAFORM)) and t4 != PLATAFORM) or  (t2 == SOLID and t4 == PLATAFORM)) {
	
		//collision found
		if (vsp > 0) {
			y = y - (y mod global.tile_size) + global.tile_size - 1 - (_side - y);
		} else { 
			y = y - (y mod global.tile_size) - (_side - y);
		}
		vsp = 0;
		//death tile check
		if (((t1 == DEATH) or (t2 == DEATH)) or (y > room_height)) {
			hp = 0;
		}
	}
	y+= vsp;
	
}