
if instance_exists(o_player) {
	if (distance_to_object(o_player) < range) {
		
		state = passaro_flying;
		dir = random_range(20,60);
		if(o_player.x > x) {
			dir = 180 - dir;
			image_yscale = -1;
		}
		sprite_index = flying_sprite;
		image_speed = 1
		image_xscale = 1;
		image_angle = dir;
	}
}

script_execute(state);
	
