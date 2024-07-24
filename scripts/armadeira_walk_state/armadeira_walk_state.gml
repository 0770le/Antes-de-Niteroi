function armadeira_walk_state(){
//set mov
	hsp = spd * facing;
	hidden = false;
	
//change state
	//idle
	if (abs(start_x - x) > patrol_dis) { //patrol_dis-- < 0
		alarm[HIDING] = hide_delay;
		state = armadeira_states.IDLE;
	}	
	// attack 
	if alert  {
		state = states.ATTACK;
	}
	
	
	////escalar ou voltar if a wall is found
	
	var t1 = tilemap_get_at_pixel(global.map, side() + sign(hsp), y);
	if (t1 == SOLID) {
		var _turn_or_climb = choose (1,2,2);
		if _turn_or_climb == 1 {
			facing*=-1;
		}else{
			state = armadeira_states.CLIMB;
		}
	}

	//apply movement
	collision();

}