instance_destroy();
var _stuck_arrow  = instance_create_depth(x,y,other.depth +1,o_generic_animation);
_stuck_arrow.sprite_index = s_arrow_stuck;
if(sprite_index == s_player_arrow) {
	_stuck_arrow.sprite_index = s_player_arrow_stuck;	
}
_stuck_arrow.image_xscale = image_xscale;
_stuck_arrow.image_angle = image_angle;
		
_stuck_arrow.attached_to = other.id;
_stuck_arrow.attach_x_off = x - other.x;
_stuck_arrow.attach_y_off = y - other.y;
_stuck_arrow.attach_flip = false;
_stuck_arrow.attach_flip_rotation = true;
_stuck_arrow.facing = other.facing;
_stuck_arrow.duration = room_speed * 5;
_stuck_arrow.fade = true;
