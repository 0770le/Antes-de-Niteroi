function frances_patrol_state(){

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
var t3 = tilemap_get_at_pixel(global.map, side() + sign(hsp) + 12*facing, y - (TILE_SIZE*2));

//cabeça
var t4 = tilemap_get_at_pixel(global.map, side(), bbox_top);
if (t4 == SOLID) {//turn back
		wait_time = random_range(4, 6) * room_speed;
		state = frances_states.IDLE;
		facing *=-1;
		patrol_destination *=-1;
}

//sees player
if alert {
//shoot
	if (line_of_sight(true) and abs(y-o_player.y)< 30 and on_screen(-20)) {
		//reload
		if !can_fire {
			state = frances_states.RELOAD;
			image_index = 0;
				
		//fire	
		} else { 
			state = frances_states.SHOOT;
			image_index = 0;
		}
	} else {
		state = frances_states.RUN;
	}
}

//calc_entity_movement();

collision();
	
}
	