function iaguara_leap_cliff_state(){
	
	if ((image_index) >= 5 ) and on_ground() {
		image_speed = 0;
		call_later(1.5* room_speed, time_source_units_frames, function() {image_speed=1;});
		y-=1;
		//x-=1*facing;
		hsp =0;
		vsp =0;
		launch(7,0);
		image_index = image_number - 1; // Garante que fique no último frame
		cliff_first_jump = true;
		call_later(3* room_speed, time_source_units_frames, function() {cliff_first_jump=false;});
	}
	
	
	
	var _face = tilemap_get_at_pixel(global.map, side(), y);
	
	//if (_face == VOID) {
	
	//	vsp = 0;
	//}
	
	//2º pulo
	if ((vsp >=  0) and cliff_first_jump and !on_ground()){ 

		//gambiarra pra fazer ela nunca deixar d subir com inconstancia misteriosa
		if (_face == SOLID){
			y-=4;
		}
			
		launch(2,2.5);
		state = iaguara_states.FALL;
		sprite_index = 0;
		image_speed = 1;
		//jump_dust(x +20*facing)//faz o objeto dust_evade
		
	}

	//sobe Plataform
	if (_face == PLATAFORM and o_player.y < y) {
		hsp =0;
		vsp =0;
		launch(5,1);
		state = iaguara_states.FALL;
		image_index=0;
	}
	
	calc_entity_movement();
	//apply movement
	
		collision();
	
}