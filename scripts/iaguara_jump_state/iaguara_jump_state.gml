function iaguara_jump_state(){

	
	//check state after anim
	if ( anim_end() and on_ground()  ) {
		state = iaguara_states.LANDING;
		image_index = 0;
	}	
	
	//tocando a parede no ar
	var face = tilemap_get_at_pixel(global.map, side() +hsp, y-sprite_height/2);
	
	if ((!on_ground() and face == SOLID)) {
		
		state = iaguara_states.HANGING;
		image_index=0;
		facing*=-1;
	}
	
	calc_entity_movement();
	//apply movement
	collision();
	

}