
function armadeira_climb_state(){
image_speed =1;	
	can_alert= false;

	vsp = -spd*0.8;
	hsp= 0 ;
	
//stop climb once finished

//chegou no solido mais alto

	var t1 = tilemap_get_at_pixel(global.map, side() +1*facing , bbox_bottom);
	var t2 = tilemap_get_at_pixel(global.map, side() +1*facing , bbox_top);
	
	
	///
	
		if  t1 != SOLID and t2 != SOLID  {		//((abs(target_y - y) > sprite_height )) 
		
			x+= +1*facing;
			state = armadeira_states.WALK;
			start_x = x;
			patrol_dis = random_range(patrol_min_dis, patrol_max_dis);
			spd = random_range(spd_min_limit, spd_max_limit);
		} 
	
	//no teto: 
	var t3 = tilemap_get_at_pixel(global.map, x , bbox_top - 1);
	if (t3 == SOLID) {
		//andar no teto
		facing *= -1;
		state = armadeira_states.WALK;	
		start_x = x;
		patrol_dis = random_range(patrol_min_dis, patrol_max_dis);
		spd = random_range(spd_min_limit, spd_max_limit);
		
	}
	
	//apply movement
	collision();

	
}

