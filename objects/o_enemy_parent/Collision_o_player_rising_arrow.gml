struck_by_arrow(other.facing, other.on_fire);

if(stuck_arrow) {
	var _stuck_arrow  = instance_create_depth(x,y,depth +1,o_generic_animation);
	_stuck_arrow.sprite_index = s_player_arrow_stuck;
	_stuck_arrow.image_xscale = other.image_xscale;
	_stuck_arrow.image_angle = other.image_angle;
		
	_stuck_arrow.attached_to = id;
	_stuck_arrow.attach_x_off = other.x - x;
	_stuck_arrow.attach_y_off = other.y - y;
	_stuck_arrow.attach_flip = false;
	_stuck_arrow.attach_flip_rotation = true;
	_stuck_arrow.facing = facing;
	_stuck_arrow.duration = room_speed * 5;
	_stuck_arrow.fade = true;
}

instance_destroy(other);