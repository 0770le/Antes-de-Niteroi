if(!stop_movement) {
	image_angle += angle_speed;
	
	var _side = bbox_left;
	if (sign(hsp) == 1) {
		_side = bbox_right;
	}

	var t1 = tilemap_get_at_pixel(global.map, _side + hsp, bbox_top);
	if (t1 == SOLID) {
		hsp *= -1;
	}
	
	t1 = tilemap_get_at_pixel(global.map, x, bbox_bottom + vsp);
	if(t1 == SOLID) {
		if (!hit_ground) { // play sound when ground is hit for the first time
			hit_ground = true;
			global.sound_controller.update_position_and_play(
				FMOD_EVENT.WOOD_BARRIER_DEBRIS,
				x, y
			);
		}
		
		if(vsp < 0) {
			vsp *= -1;
		} else {
			if bounce >= 2 {
				stop_movement = true;
				exit;
			}
			vsp *= -0.7;
			bounce++;
			angle_speed *= -0.7;
		}
	}
	

	//destroy debris if falls out of room
	if (y > room_height) {
		instance_destroy();
	}

	//movement 
	calc_entity_movement(grav, 0.01);
	
	x += hsp*facing;
	y += vsp;
}