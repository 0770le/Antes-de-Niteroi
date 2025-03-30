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


//cabeça
var t4 = tilemap_get_at_pixel(global.map, side(), bbox_top);
var _wall = place_meeting(side(), y, o_wood_wall);

if (t4 == SOLID or _wall) {//turn back
		wait_time = random_range(4, 6) * room_speed;
		state = frances_states.IDLE;
		facing *=-1;
		patrol_destination *=-1;
}

//sees player
if alert {
	stare();
	
	var _opp_side = side(false) -3*facing;
	var _t0 = tilemap_get_at_pixel(global.map, _opp_side, bbox_bottom-2);
	var _t1 = tilemap_get_at_pixel(global.map, _opp_side, bbox_bottom+2);
	var _wall = place_meeting(_opp_side, y, o_wood_wall);
	
	if !can_fire {
		state = frances_states.RELOAD;
		image_index = 0;
	}
	if (line_of_sight(true) and abs(y-o_player.y)< 30 and on_screen(-20)) {
		if(can_fire) { 
			state = frances_states.SHOOT;
			image_index = 0;
		}
	} else if(abs(o_player.x - x) < 200 and _t0 != SOLID and _t1 != VOID and !_wall) {
			state = frances_states.RUN;
	}
}

calc_entity_movement();

collision();
	
}
	