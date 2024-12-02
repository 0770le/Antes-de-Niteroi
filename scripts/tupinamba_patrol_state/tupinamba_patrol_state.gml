function tupinamba_patrol_state(){
image_speed =1;

//set mov
//go for destination
if (patrol_destination == -1 and x > patrol_left_limit) or (patrol_destination == 1 and x < patrol_right_limit){
	facing = patrol_destination;
	hsp = spd * facing;
	x += hsp;
} else {//switching destination on end of path
	wait_time = random_range(4, 6) * room_speed;
	state = tupinamba_states.IDLE;
	patrol_destination *= -1;
}

//pula
// a wall is found	
var t1 = tilemap_get_at_pixel(global.map, side() + sign(hsp) + 12*facing, y);
//cabeça
var t2 = tilemap_get_at_pixel(global.map, side(), bbox_top);


if (t1 == SOLID or t2 == SOLID)  {
	state =  tupinamba_states.JUMP;
	image_index = 0;
	image_speed = 1;
	launch(jump_vsp, jump_hsp);
}

//fall	
if vsp != 0 and !on_ground() {
	state = tupinamba_states.JUMP;
	image_index = 0;
	image_speed = 1;
} 

//sees player
if alert {
//shoot
	if can_attack {
	state = tupinamba_states.SHOOT;
	can_fire = true;
	image_index=0;
	} //else {//skirmish	
}

//calc_entity_movement();

collision();
	
}
	