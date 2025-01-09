
//movement 
calc_entity_movement();

if hp <= 0 {
	die = true;
}

image_xscale = facing;

 if die {
	instance_destroy();
 }

