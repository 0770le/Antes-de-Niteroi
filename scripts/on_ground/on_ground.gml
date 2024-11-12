//returns if on ground
function on_ground(){

	var _bottom = bbox_bottom;
	var t1 = tilemap_get_at_pixel(global.map, bbox_left, _bottom + 1);
	var t2 = tilemap_get_at_pixel(global.map, bbox_right, _bottom + 1);

if  ((t1 == SOLID or t1 == PLATAFORM) or (t2 == SOLID or t2 == PLATAFORM)) 
	return true else return false;


	//var _bottom = bbox_bottom;
	//var t1 = tilemap_get_at_pixel(global.map, bbox_left, _bottom + 1);
	//var t2 = tilemap_get_at_pixel(global.map, bbox_right, _bottom + 1);
	
	//var t3 = tilemap_get_at_pixel(global.map, bbox_left, _bottom);
	//var t4 = tilemap_get_at_pixel(global.map, bbox_right,_bottom);

	//if  ((t1 == SOLID or t1 == PLATAFORM) and (t3 != SOLID and t3 != PLATAFORM) or (t1 == SOLID and t3 == PLATAFORM) or	
	//	(t2 == SOLID or t2 == PLATAFORM) and (t4 != SOLID and t4 != PLATAFORM) or (t1 == SOLID and t3 == PLATAFORM))
	//	return true else return false;
}