///anim();
function anim() {
	sprite_index = sprites_array[state];
	mask_index = mask_array[state];
	image_xscale = facing;
	
	switch(state) {
		case states.JUMP:
			if (vsp < 0) {
				if(image_index >= 3)
					image_index = 1;
			} else{
				if(image_index >= 7)
					image_index = 5;
			}
		break;
			
		case states.HURTING:
				if (!on_ground()) {
					if(o_game.has_bow) {
						sprite_index = s_player_bow_hurting_air;
					} else {
						sprite_index = s_player_hurting_air;
					}
				}
		break;
		
		case states.SHOOT:
				if (!on_ground()) {
					sprite_index = s_player_bow_air_shoot;
				} else { //on ground
					if down {//atirar abaixado
						sprite_index = s_player_bow_crouched_shoot;
					} else {//normal
						sprite_index= s_player_bow_shoot;
					}
				}
		break;
		
	}
}