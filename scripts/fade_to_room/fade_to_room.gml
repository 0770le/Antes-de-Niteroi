function fade_to_room(_target_room,_x,_y,_facing,_col = c_black){
	var _fade = instance_create_layer(x, y, LAYER_CONTROLLERS, o_fade);
	with(_fade) {
		target_rm = _target_room;
		target_x = _x;
		target_y = _y;
		facing = _facing;
		col = _col;
	}
	
	//if (int64(_target_room) != int64(rm_main_menu))
	//{
	//	global.options_controller.set_option(OPTIONS_IS_NEW_GAME, false);
	//	global.options_controller.set_option(OPTIONS_LAST_ROOM, int64(_target_room));
	//	global.options_controller.set_option(OPTIONS_SPAWN_X, _x);
	//	global.options_controller.set_option(OPTIONS_SPAWN_Y, _y);
	//}
}