//movement 
calc_entity_movement();

//bounce
if ((on_ground() == true) and (bounce == false)){
	//give vert movement
	vsp = vsp_initial * random_range(.7, .8);
	bounce = true;
	can_pickup = true;
}

//bounce off walls
if (sign(hsp_initial) == true) {
	var _side = bbox_right;
} else {
	var _side = bbox_left;
}

var t1 = tilemap_get_at_pixel(global.map, _side + sign(hsp_initial), bbox_bottom);
if (t1 == SOLID) {
	//wall found, reverse direction
	hsp = hsp_initial* .75 * -1;
}

//destroy hp if falls out of room
if (y > room_height) {
	instance_destroy(id, false);
}


//collision
collision();

//update light position
with(light_id) {
	x = other.x;
	y = other.y;
}


