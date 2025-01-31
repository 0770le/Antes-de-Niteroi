function chevalier_anim(){	
	
	sprite_index = sprites_array[state];
	image_xscale = -facing;
	
	if((state == chevalier_states.IDLE or state == chevalier_states.ENGAGED) and o_player.y < bbox_top) {
		sprite_index = s_chevalier_idle_up;	
	} else if(state == chevalier_states.CHASE and o_player.y < bbox_top) {
		sprite_index = s_chevalier_chase_up;	
	}
	
}