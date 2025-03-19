function iaguara_jump_state(){
	
	//check state after anim	
	//tocando a parede no ar
	var face = tilemap_get_at_pixel(global.map, side()+hsp, y-sprite_height/2);
	
	if (face == SOLID) {
		state = iaguara_states.HANGING;
		image_index=0;
		facing*=-1;
	} else if(on_ground()) {
		state = iaguara_states.LANDING;
		image_index = 0;
	}	
	
	//sobe plataforma
	//if (face == PLATAFORM) {
	//	hsp =0;
	//	vsp =0;
	//	launch(5,1.5);
	//	state = iaguara_states.FALL;
	//	image_index=0;
	//}
	
	calc_entity_movement();
	//apply movement
	collision();
	

}