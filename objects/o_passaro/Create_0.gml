
spd = 0;
range = 0;
flying_sprite = undefined;

dir = 0;
image_xscale = choose(-1,1);

function passaro_idle() {
	if(anim_end()) {
		image_speed = 0;
	}
	
	if(image_speed == 0 and random(300) < 2) {
		image_speed = 1;
		image_index = 0;
	}
}

function passaro_flying() {
	
	//moving
	x+= spd*dcos(dir);
	y-= spd*dsin(dir);

	//destroy if leaving room
	if ( !on_screen(100)) {
		instance_destroy();
	}
}


state = passaro_idle;

	
	
	
