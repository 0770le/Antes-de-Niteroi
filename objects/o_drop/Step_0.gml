image_angle += angle_speed;

//bounce
if on_ground() { 
	//give vert movement
	
	if bounce >= 2 {
		instance_destroy();
	}
		if bounce == 0 {
			vsp = vsp_initial*0.7;
		} else { 
			vsp = vsp_initial*0.5;
		}	
	bounce++;
	y += vsp;
	angle_speed *= -0.7;
}

//bounce off walls
if (sign(hsp) == true) {
	var _side = bbox_right;
} else {
	var _side = bbox_left;
}

var t1 = tilemap_get_at_pixel(global.map, _side + sign(hsp_initial), bbox_top);
	
		if (t1 == SOLID) {
			//wall found, reverse direction
			hsp_initial *= -1;
		}
	

//destroy debris if falls out of room
if (y > room_height) {
	instance_destroy();
}

//movement 
calc_entity_movement(grav,);

hsp = hsp_initial;

//collision
collision();