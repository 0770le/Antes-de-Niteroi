function tupinamba_melee_patrol_state(){

//set mov
//go for destination
if (patrol_destination == -1 and x > patrol_left_limit) or (patrol_destination == 1 and x < patrol_right_limit){
	facing = patrol_destination;
	hsp = spd * facing;
	x += hsp;
} else {//switching destination on end of path
	state = tupinamba_melee_states.IDLE;
	in_idle_state = true;
	patrol_destination *= -1;
}

//pula
// a wall or a void floor is found	
var step = tilemap_get_at_pixel(global.map, side() + hsp, y-1);
var face = tilemap_get_at_pixel(global.map, side(), bbox_top);

if (face == SOLID)  {
	state =  tupinamba_states.JUMP;
	image_index = 0;
	launch(jump_vsp, jump_hsp);
}

//fall	
if vsp != 0 and !on_ground() {
	state = tupinamba_melee_states.JUMP;
	image_index = 0;
} 

if alert {
	state = tupinamba_melee_states.CHASE;
	image_index = 0;
	//chase start position
	start_x = x;
	start_y = y;
}

calc_entity_movement();
collision();
	
}
	