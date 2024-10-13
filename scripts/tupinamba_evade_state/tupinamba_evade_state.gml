
function tupinamba_evade_state(){

	//caculate movement
	calc_entity_movement(grav*0.9)
	
	//check state
	//change state after touching ground
	if on_ground() {
		//change state
		hsp=0;
		state = tupinamba_states.IDLE;
		image_index = 0;
		image_speed = 1;
	}
	
	//tocando a parede no ar
	var back = tilemap_get_at_pixel(global.map, side(false) -1*facing, y-1);
	
	if (back == SOLID) and (vsp > 0.24) { // vsp caindo q entra no sliding
			wait_time = room_speed * 0.4;
			facing *= -1;
			state = tupinamba_states.HANGING;
			//pro começo do arrastar nao ficar truncado
			vsp += 1; 
			can_take_dmg = true;
	}
	

	//apply movement
	collision();
	//apply animations
	anim();

}