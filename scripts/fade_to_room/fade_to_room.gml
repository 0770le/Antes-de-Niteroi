function fade_to_room(_target_room,_x,_y,_facing,_col = c_black){
	var _fade = instance_create_layer(x, y, LAYER_CONTROLLERS, o_fade);
	with(_fade) {
		target_rm = _target_room;
		target_x = _x;
		target_y = _y;
		facing = _facing;
		col = _col;
		
	}
}