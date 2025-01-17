if(!stop_movement) {
	image_angle += angle_speed;

	var t1 = tilemap_get_at_pixel(global.map, x, bbox_bottom + vsp);
	if(t1 == SOLID) {
		//give vert movement
	
		if bounce >= 2 {
			stop_movement = true;
			exit;
		}
		vsp *= -0.7;
		bounce++;
		angle_speed *= -0.7;
	}
	//bounce off walls
	
	var _side = bbox_left;
	if (sign(hsp) == 1) {
		_side = bbox_right;
	}

	var t1 = tilemap_get_at_pixel(global.map, _side + hsp, bbox_top);
	if (t1 == SOLID) {
		//wall found, reverse direction
		hsp *= -1;
	}
	

	//destroy debris if falls out of room
	if (y > room_height) {
		instance_destroy();
	}

	//movement 
	calc_entity_movement(grav, 0.01);
	
	x += hsp;
	y += vsp;
}