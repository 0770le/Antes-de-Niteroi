
function jararaca_climb_state(){	
	vsp = lerp(vsp, -gear_spd, spd);
	hsp = 0;
//stop climb once finished
	//lado escalado
	
//chegou no solido mais alto

	var t1 = tilemap_get_at_pixel(global.map, side() + 1*facing, bbox_bottom);
	if (t1 != SOLID) {
		//subindo no solido
		if (abs(start_x - x) < abs(sprite_width/2)) {
			hsp = facing* lerp(hsp, gear_spd, spd); 			
			vsp =0;
		} else {
		state = jararaca_states.MOVING;
		}	
	} 
	
	//parar no teto 
	var t2 = tilemap_get_at_pixel(global.map,x , bbox_top-1);
	if (t2 == SOLID) {
		facing*=-1;
		state = jararaca_states.MOVING;
	}
	
	//apply movement
	collision();

	
}

