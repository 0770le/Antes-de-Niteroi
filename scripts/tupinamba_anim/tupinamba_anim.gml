function tupinamba_anim(){	
	
	
	
	sprite_index = sprites_array[state];
	image_xscale = -facing;
	
	if (state ==  tupinamba_states.SHOOT) { 
		var _dir = point_direction(x,y,o_player.x, o_player.y);
		var _angle = 25;
		
	//nao seguir/mudar depois q mirou
		
		if(sprite_stoped) {			
			sprite_index = sprite_aux;
		} else {	
			//up
			if (_dir > _angle and _dir < 180 - _angle) {
				sprite_index = s_tupinamba_shoot_up;
			// down	
			} else if (_dir > 180+ _angle and (_dir < 360 - _angle)) {
				sprite_index = s_tupinamba_shoot_down;	
			}  
		}
	}
}