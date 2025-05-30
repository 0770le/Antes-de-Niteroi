//move towards move_to_x and move_to_y
x = lerp(x, move_to_x, camera_pan_speed);
y = lerp(y, move_to_y, camera_pan_speed);

if(camera_created) {
	camera_set_view_pos(camera, x- camera_get_view_width(camera)/2, y - camera_get_view_height(camera)/2);

	if (instance_exists(follow)) {
		move_to_x = follow.x;
		move_to_y = follow.y + y_offset;  
	
		var xx = clamp(camera_get_view_x(camera), 0 , room_width - camera_get_view_width(camera)); //mantem a camera na tela
		var yy = clamp(camera_get_view_y(camera), 0 , room_height - camera_get_view_height(camera)); //mantem a camera na tela

		//screen_shake
		if (screen_shake == true) {
			xx += random_range(-screen_shake_amount, screen_shake_amount);
			yy += random_range(-screen_shake_amount, screen_shake_amount);
	
		}

		camera_set_view_pos(camera, xx, yy);
	} else {
		x = 0;
		y = 0;
	
		camera_set_view_pos(camera, x, y);
	}

	//OVERRIDE CAMERA
	//camera_set_view_pos(camera, 1053, 406);
	
	//camera variables
	global.cx = camera_get_view_x(camera);
	global.cy = camera_get_view_y(camera);
	global.cw = camera_get_view_width(camera);
	global.ch = camera_get_view_height(camera);

}

//if(global.timer mod 10 == 0) {
//	o_sound_controller.set_listener_position(global.cx + global.cw/2, global.cy + global.ch/2);
//}

notify();

//background scrolling
//var layer_id = layer_get_id("Background");
//layer_x(layer_id, lerp(0, camera_get_view_x(view_camera[0]), 0.7));
//layer_y(layer_id, lerp(0, camera_get_view_y(view_camera[0]), 0.4));

