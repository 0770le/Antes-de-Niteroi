
function player_walk_state(){
 
	//get input
	get_input();

	//caculate movement  
	calc_movement();
	
	//check state
	if (hsp == 0) {
		state = states.IDLE;
	}
	
	 //check if falling off ledge
	 var _bottom = bbox_bottom;
	 var t1 = tilemap_get_at_pixel(global.map, bbox_left, _bottom + 1);
	 var t2 = tilemap_get_at_pixel(global.map, bbox_right, _bottom + 1);
	 
	 if ((t1 == VOID) and (t2 == VOID)) {
		state= states.JUMP;
		jumps= jumps_initial;
	 }
	 
	 
	if attack{
		state = states.ATTACK;
		image_index =0;
	}
	
	if jump {
		jumped();
	}
	
	if evade {
		evaded();
		image_index =0;
	}
	
	if shoot {
		state= states.SHOOT;
		image_index =0;
	}
	
	if down {
		crouched();
	}
	
	//apply movement
	collision();
	
	//check player hp
	check_player_hp();

	//apply animations
	anim();
}