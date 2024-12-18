
//movement 
calc_entity_movement();
 
//collision
collision();

stare(); 
image_xscale = facing;

if(quest_step > 0 and point_distance(x,y,step1_x,step1_y) > 100) {
	x = step1_x;
	y = step1_y;
}


