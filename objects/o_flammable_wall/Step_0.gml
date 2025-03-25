
//movement 
calc_entity_movement();

if (on_fire) {
	if ( sprite_index != s_flammable_wall_burning) {
		sprite_index = s_flammable_wall_burning;
		image_index = 0;
	} else if (anim_end()) {
		die = true;
	}
}

image_xscale = facing;


//generate debris
 if die {
	instance_destroy();
	with(instance_create_layer(x,y,layer,o_generic_animation)) {
		sprite_index = s_flammable_wall_burned;
		image_xscale = other.facing;
	}
 }

