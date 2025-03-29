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
	
	
	
	
	
	//leap over a 4 solid block wall (checa pelo 2º solido acima do chao e checa pelo vazio na altura do quinto espaço acima do chao) 
	
	var _face = tilemap_get_at_pixel(global.map, side()+1*facing, bbox_top-1);
	var _step_up = tilemap_get_at_pixel(global.map, side()+1*facing, bbox_top - (TILE_SIZE* 3)-1);
	//solido 2º de cima e void 5º de cima e player na frente da onça
	if(((_face == SOLID)and(_step_up == VOID)) and ((facing == 1 and o_player.x > x) or (facing == -1 and o_player.x < x))) {
	
		state = iaguara_states.LEAP_CLIFF;
		image_index = 0;
		image_speed=1;
	}	
	
	
	
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