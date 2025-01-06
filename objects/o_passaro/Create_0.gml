

facing = choose(-1,1);
vspd = random_range(-3,-4);
hspd = random_range(4,5);

state = "idle";

//states
//enum passaro_states {
//	IDLE,
//	FLYING
//}

//state = passaro_states.IDLE;

//states_array[passaro_states.IDLE] = passaro_idle_state;
//states_array[passaro_states.FLYING] = passaro_flying_state;

//sprites_array[passaro_states.IDLE] = s_passaro_idle;
//sprites_array[passaro_states.FLYING] = s_passaro_flying;

function passaro_idle() {
	
	//anim
	sprite_index = s_passaro_idle;
	image_xscale = -facing;

}

function passaro_flying() {
	
	//anim
	sprite_index = s_passaro_flying;
	image_xscale = -facing;
	
	//moving
	y+= vspd;
	x+= hspd*facing;

	//destroy if leaving room
	
	if ( !on_screen(100)) {
		instance_destroy();
	}
}

	
	
	
