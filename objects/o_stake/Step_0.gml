
//movement 
calc_entity_movement();

if hp <= 0 {
	die = true;
}


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
 
//collision
collision();
