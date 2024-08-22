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
		
		case states.ATTACK:
			if (!on_ground()) {
				sprite_index = s_player_air_attack;
			} else { //on ground
				if (hsp != 0) {
					sprite_index= s_player_attack_walk;
				} else { 
					sprite_index = s_player_attack;
				}
			}
		break;
			
		case states.HURTING:
				if (!on_ground()) {
					sprite_index = s_player_jump;
					if (vsp < 0) {
						image_index = 0;
					} else {
						image_index = 1;
					}
				}
		break;
		
		case states.SHOOT:
				if (!on_ground()) {
					sprite_index = s_player_air_shoot;
				} else { //on ground
					if down {//atirar abaixado
						sprite_index = s_player_crouched_shoot;
					} else if up {//pra cima
						sprite_index = s_player_rising_shoot;
					} else {//normal
						sprite_index= s_player_shoot;
					}
				}
		break;
	}
}