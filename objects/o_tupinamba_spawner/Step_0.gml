event_inherited();

//movement 
//calc_entity_movement();

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
	 //right
	repeat(right_debris) {
		var inst = instance_create_depth(x,y-32, depth, o_debris);
	}
	//left
	repeat(left_debris) {
		var inst = instance_create_depth(x,y-32, depth, o_debris);
		with(inst.id) {
			hsp *= -1;
			facing *= -1;
		}
	}
	instance_destroy();
 }

