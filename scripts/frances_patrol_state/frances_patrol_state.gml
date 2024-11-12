function frances_patrol_state(){
image_speed =1;

//set mov
//go for destination
if (patrol_destination == -1 and x > patrol_left_limit) or (patrol_destination == 1 and x < patrol_right_limit){
	facing = patrol_destination;
	hsp = spd * facing;
	x += hsp;
} else {//switching destination on end of path
	wait_time = random_range(4, 6) * room_speed;
	state = frances_states.IDLE;
	patrol_destination *= -1;
}


// a wall is found	
var t1 = tilemap_get_at_pixel(global.map, side() + sign(hsp) + 12*facing, y);
var t2 = tilemap_get_at_pixel(global.map, side() + sign(hsp) + 12*facing, y - TILE_SIZE);



if (t1 == SOLID) {
	//jump
	if (t2 != SOLID)  {
		state =  frances_states.JUMP;
		image_index = 0;
		image_speed = 1;
		launch(jump_vsp, jump_hsp);
	} else {
//too hight, turn back
		wait_time = random_range(4, 6) * room_speed;
		state = frances_states.IDLE;
		facing *=-1;
		patrol_destination *=-1;
	}
}	

//fall	
if vsp != 0 and !on_ground() {
	state = frances_states.JUMP;
	image_index = 0;
	image_speed = 1;
} 

//sees player
if alert {
//shoot
	if can_fire {
	state = frances_states.RELOAD;
	image_index=0;
	} //else {//skirmish	
}

//calc_entity_movement();

collision();
	
}
	