///anim(); 
function frog_anim() {
	sprite_index = sprites_array[state];
//	mask_index = mask_array[state];
	image_xscale = facing;
	
	//animaçao subindo caindo certo
	switch(state) {
		case frog_states.JUMP:
			if  image_index >=2 {
				image_speed = 0;
				if vsp <0 image_index =2 else image_index = 3;
			}
		break;
		
	}
}