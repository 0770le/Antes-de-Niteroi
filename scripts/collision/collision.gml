function collision(_remove_decimal = true) {
	//apply carried over decimals
	if(_remove_decimal) {
		hsp += hsp_decimal;
		vsp += vsp_decimal;
	
		//floor decimals
		//save and subtracting decimals (making sure collisions use hole numbers)
		hsp_decimal = hsp - (floor(abs(hsp)) * sign(hsp));
		hsp -= hsp_decimal;
		vsp_decimal = vsp - (floor(abs(vsp)) * sign(vsp));
		vsp -= vsp_decimal;
	}
	
	//removing inside all for safety
	//esquerda
	
	var t1 = tilemap_get_at_pixel(global.map, bbox_left, y-5);
	var t2 = tilemap_get_at_pixel(global.map, x, y-5);	
	if(t1 == SOLID and t2 != SOLID) {
		while(t1 == SOLID) {
			x = bbox_left + global.tile_size - (bbox_left mod global.tile_size) + (x - bbox_left);
			t1 = tilemap_get_at_pixel(global.map, bbox_left, y-5);
		}
	}
	
	//direita
	t1 = tilemap_get_at_pixel(global.map, bbox_right, y-5);
	t2 = tilemap_get_at_pixel(global.map, x, y-5);	
	if(t1 == SOLID and t2 != SOLID) {
		while(t1 == SOLID) {
			x = bbox_right - (bbox_right mod global.tile_size) - 1 - (bbox_right - x);	
			t1 = tilemap_get_at_pixel(global.map, bbox_right, y-5);
		}
	}
	
	//horizontal collision
	var _side;
	//determine wich side to test
	if (hsp > 0) {
		_side = bbox_right;
	} else {
		_side = bbox_left;
	}

	//check top and bottom of side
	t1 = tilemap_get_at_pixel(global.map, _side + hsp, bbox_top);
	t2 = tilemap_get_at_pixel(global.map, _side + hsp, bbox_bottom);	

	if (t1 == SOLID or t2 == SOLID) {
		//collision found
		//indo para a direita
		if (hsp > 0) {
			x = _side - (_side mod global.tile_size) + global.tile_size - 1 - (_side - x);	
		//esquerda
		}else{
			
			var _diff = (_side+hsp) mod global.tile_size;
			var _diff2 = global.tile_size - _diff;
			
			var x1 = (_side+hsp) + _diff2;
			x = x1 + (x - _side);
			
			
			
			
			//x = (_side+hsp) - ((_side+hsp) mod global.tile_size) + (x - _side);
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
	if (!death_protection and ((vt1 == DEATH) or (vt2 == DEATH)) or (y > room_height)) {
		hp = 0;
	} else if ((vt1 != VOID and vt1 != DEATH) and (((vsp > 0 or vt1 != PLATAFORM)) and vt3 != PLATAFORM) or (vt1 == SOLID and vt3 == PLATAFORM)) or
	   ((vt2 != VOID and vt2 != DEATH) and (((vsp > 0 or vt2 != PLATAFORM)) and vt4 != PLATAFORM) or  (vt2 == SOLID and vt4 == PLATAFORM)) {
		
		
		if (vsp > 0) { //floor
			y = (bbox_bottom+vsp) - ((bbox_bottom+vsp) mod global.tile_size) - 1 - (bbox_bottom - y);
		} else { //ceiling
		
			var _diff = (vsp + bbox_top) mod global.tile_size;
			var _diff2 = global.tile_size - _diff;
			
			var y1 = bbox_top + vsp + _diff2;
			y = y1 + (y - bbox_top);
		}
		vsp = 0;
		//death tile check
	}
	
	y+= vsp;
	
	while(bbox_left < 0) {
		x++;	
	}
	
	while(bbox_right > room_width) {
		x--;	
	}
	
}