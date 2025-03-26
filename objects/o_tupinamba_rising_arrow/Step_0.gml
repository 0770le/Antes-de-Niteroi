
speed = clamp(speed, min_spd , max_spd);
gravity= grav;

//direction image
image_angle = (direction) ;

image_xscale =1;

var t2 = tilemap_get_at_pixel(global.map, side() , bbox_bottom);
if t2 == SOLID{
	instance_destroy();
	
	var _stuck_arrow  = instance_create_depth(x,y,other.depth +1,o_generic_animation);
	_stuck_arrow.sprite_index = s_arrow_stuck;
	_stuck_arrow.image_xscale = image_xscale;
	_stuck_arrow.image_angle = image_angle;
	_stuck_arrow.duration = room_speed * 5;
	_stuck_arrow.fade = true;
}


//destroy if leaving room
if (t2 == -1) {
	instance_destroy();
}
