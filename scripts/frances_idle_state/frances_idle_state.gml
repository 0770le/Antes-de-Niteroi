
function frances_idle_state() {
//sees player
	if(turret) {
		alert = true;	
	}

	if alert {
		stare()
		
		////avoid arrow
		//if (distance_to_object(o_player_arrow) < TILE_SIZE) {
		//	state = frances_states.DUCK;
		//	image_index = 0;
		//}
		
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
		} else if(abs(o_player.x - x) < 200 and _t0 != SOLID and _t1 != VOID and !_wall and !turret) {
			state = frances_states.RUN;
		}
	//not alert	
	} else {
		//patrol  
		if patrol and wait_time-- < 0  {
			state = frances_states.PATROL;
			image_index = 0;
		} 
	}
	
	calc_entity_movement();
	//apply movement
	collision();
	
}

