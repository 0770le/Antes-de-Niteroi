
function armadeira_climb_state(){
	
	//roda 1x
	if can_alert {
		start_x = x;
	}
	can_alert= false;
	hidden = false;
	vsp = -spd*0.6 ;
	hsp= 0 ;
	
//stop climb once finished

	
//chegou no solido mais alto
	var t1 = tilemap_get_at_pixel(global.map, side() +1*facing , bbox_bottom);
	if (t1 != SOLID) {
		//subindo no solido
		if (abs(start_x - x) < abs(sprite_width)) {
			vsp = 0;
			hsp += facing* spd; 			
		} else {
		state = armadeira_states.IDLE;
		alarm[HIDING] = hide_delay;
		can_alert = true;
		}	
	} 
	
	//no teto: virar e pular
	var t2 = tilemap_get_at_pixel(global.map, x, bbox_top-1);
	if (t2 == SOLID) {
		facing*=-1;
		state = armadeira_states.JUMP;
		y += 1
		launch(0,2);
	}
	//apply movement
	collision();

	
}

