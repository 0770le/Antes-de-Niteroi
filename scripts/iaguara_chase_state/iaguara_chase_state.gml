function iaguara_chase_state() {
	
	//calculate target movement
	image_speed = 1;
	target_x = o_player.xprevious;
	target_y = o_player.yprevious;
	if(	abs(x - o_player.x) > 10) {
		stare();
	}
	
	//calculate movement
	var _dir = point_direction(x, y, target_x, target_y);
	
	hsp = clamp(hsp + (facing*acc), -max_hsp, max_hsp);

	//if knock back, don´t advance
	if ((!hurt) and (alarm[KNOCKEDBACK] < 0 )) {
		if ((abs(x - target_x) <= attack_range) and  o_player.hp > 0){
				iaguara_attack();
		}
	}
	
	//go to idle if not mooving
	if (hsp ==  0) {// (hsp == 0 and !alert) {
		state = iaguara_states.IDLE;
		image_index = 0;
	}
	
	
	var face = tilemap_get_at_pixel(global.map, side()+hsp + 20*facing, y);
	var _step_up = tilemap_get_at_pixel(global.map, side()+hsp, y- TILE_SIZE-1);
		
	if (o_player.hp > 0) {
		descend();
		
		
	} 
	//if (face == SOLID){////up
		
	//	if (_step_up != SOLID) {//low
	//		state = iaguara_states.STAIR_UP;
	//			call_later(TILE_SIZE/spd, time_source_units_frames,function() {if(state ==  iaguara_states.STAIR_UP){ state = iaguara_states.CHASE;} } ,false);
	//	}	
		
	//	//state = iaguara_states.ATTACK;
	//	//image_index =0;
	//}

	calc_entity_movement(global.grav, 0);
	collision(false);

}