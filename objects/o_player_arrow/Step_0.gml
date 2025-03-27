//movement
hsp = spd * facing;
image_xscale = sign(hsp);

fire.visible = on_fire;

var t1 = tilemap_get_at_pixel(global.map, side() + sign(hsp), y);

if (t1 == SOLID) {
	instance_destroy();
	
	var _stuck_arrow  = instance_create_depth(x,y,other.depth +1,o_generic_animation);
	_stuck_arrow.sprite_index = s_player_arrow_stuck;
	_stuck_arrow.image_xscale = image_xscale;
	_stuck_arrow.image_angle = image_angle;
	_stuck_arrow.duration = room_speed * 5;
	_stuck_arrow.fade = true;
}


x += hsp;

//destroy if leaving room
if ( t1 == -1) {
	instance_destroy();
}
