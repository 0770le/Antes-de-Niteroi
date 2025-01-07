if(image_speed > 0) {
	image_xscale = -facing;
	if(image_index > image_number - 3) {
		image_speed = 0;
	}
} else {
	if(vspd > 0) {
		image_index = image_number - 2;
	} else {
		image_index = image_number - 1;
	}
}


if(!stop_movement) {
	x+=hspd*-facing;
	y+=vspd;

	vspd+=global.grav;

	//bounce
	if(bouncerTimer-- <= 0) {
		if(on_ground_2()) {
			if bounce >= 2 {
				stop_movement = true;
				vspd = 0;
			} else {
				vspd = vspd * (-0.4);
				bounce++;
				bouncerTimer = 5;
			}
		}
		var _side = sign(hspd) == 1?bbox_right:bbox_left;

		var t1 = tilemap_get_at_pixel(global.map, _side + sign(hspd), bbox_top);
		if (t1 == SOLID) {
			hspd *= -0.5;
		}
	}

	if (y > room_height) {
		instance_destroy();
	}
}