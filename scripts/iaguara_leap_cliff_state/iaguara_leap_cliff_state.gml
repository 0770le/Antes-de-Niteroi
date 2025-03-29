// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function iaguara_leap_cliff_state(){
	
	

	if ((image_index) >= 5 ) and on_ground() {
		hsp=0;
		vsp=0;
		y-=1;
		x-=1*facing;
		launch(7,0);
		image_index = image_number - 1; // Garante que fique no último frame
		cliff_first_jump = true;
		call_later(2, time_source_units_seconds, function() {cliff_first_jump=false;});
	}
	
	
	if ((vsp  == 0) and cliff_first_jump){//!on_ground()) {
		launch(2,3);
		state = iaguara_states.FALL;
		sprite_index = 0;
		image_speed = 1;
		jump_dust()//faz o objeto dust_evade
	}
	
	var _face = tilemap_get_at_pixel(global.map, side()+hsp, y);
	
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