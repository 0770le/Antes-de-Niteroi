//returns if on ground
function on_ground(){

//	var _bottom = bbox_bottom;
//	var t1 = tilemap_get_at_pixel(global.map, bbox_left, _bottom + 1);
//	var t2 = tilemap_get_at_pixel(global.map, bbox_right, _bottom + 1);

//if  ((t1 == SOLID or t1 == PLATAFORM) or (t2 == SOLID or t2 == PLATAFORM)) 
//	return true else return false;


	var _bottom = bbox_bottom;
	var t1 = tilemap_get_at_pixel(global.map, bbox_left, _bottom + 1);
	var t2 = tilemap_get_at_pixel(global.map, bbox_right, _bottom + 1);
	
	var t3 = tilemap_get_at_pixel(global.map, bbox_left, _bottom);
	var t4 = tilemap_get_at_pixel(global.map, bbox_right,_bottom);

	return  ((((t1 == SOLID or t1 == PLATAFORM) and (t3 != SOLID and t3 != PLATAFORM)) or (t1 == SOLID and t3 == PLATAFORM)) or	
		(((t2 == SOLID or t2 == PLATAFORM) and (t4 != SOLID and t4 != PLATAFORM)) or (t1 == SOLID and t3 == PLATAFORM)));
}

function on_ground_2(_instance, _platform = true){
	var _t = tilemap_get_at_pixel(global.map, _instance.x, _instance.bbox_bottom + 1);

	return  (_t == SOLID or (_platform and _t == PLATAFORM))
}

function on_ground_3(_instance, _platform = true){
	var _t1 = tilemap_get_at_pixel(global.map, _instance.bbox_left, _instance.bbox_bottom + 1);
	var _t2 = tilemap_get_at_pixel(global.map, _instance.bbox_left, _instance.bbox_bottom + 1);

	return  _t1 == SOLID or _t2 == SOLID or (_platform and (_t1 == PLATAFORM or _t2 == PLATAFORM));
}

function find_ground(_x, _y, _dir) {
	var _t = tilemap_get_at_pixel(global.map, _x, _y);
	
	while(_t == SOLID or _t == PLATAFORM) {
		_y+=_dir;
		_t = tilemap_get_at_pixel(global.map, _x, _y);
	}
	
	return {x : _x, y : _y};
}

function find_wall(_x, _y, _dir) {
	var _t = tilemap_get_at_pixel(global.map, _x, _y);
	
	while(_t == SOLID or _t == PLATAFORM) {
		_x+=_dir;
		_t = tilemap_get_at_pixel(global.map, _x, _y);
	}
	
	return {x : _x, y : _y};
}