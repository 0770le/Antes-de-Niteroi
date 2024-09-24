
speed = clamp(speed, min_spd , max_spd);
gravity= grav;

//direction image
image_angle = (direction) ;

image_xscale =1;// sign(hsp);
var t1 = 0;
var t2 = 0;


//stop if dead
if die {
	speed=0;
	instance_destroy(tail_id);
	instance_destroy(tail_id2);
}

var t2 = tilemap_get_at_pixel(global.map, side() + sign(speed), bbox_bottom);
if t2 == SOLID{die=true}


	
//play animation
if (die) {
	//jump to image 1 the first time we run die
	if (image_speed != 1) {
		image_index = 1;
	} 
	image_speed = 1;
	if (image_index == 1){
		audio_play_sound(snd_arrow_die, 20, false, global.volume);
	}
	//play arrow die sound only if arrow is on screen
	if (on_screen(400)) {
		if (image_index == 1){
			audio_play_sound(snd_arrow_die, 20, false, global.volume);
		}
	}
}

//destroy if leaving room
if (( t1 == -1) or (t2 == -1)) {
	instance_destroy();
}
