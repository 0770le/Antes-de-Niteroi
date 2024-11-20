//movement
hsp = spd * facing;
image_xscale = sign(hsp);
var t1 = 0;
var t2 = 0;


//stop if dead
if (die) {
	hsp = 0;
}

//destroy at wall if moved more than one tile
if (abs(xstart - x) > TILE_SIZE) { // global.tile_size) {
	var t1 = tilemap_get_at_pixel(global.map, side() + sign(hsp), bbox_top);
	var t2 = tilemap_get_at_pixel(global.map, side() + sign(hsp), bbox_bottom);

	if (((t1 == SOLID) or (t1 == -1)) or ((t2 == SOLID) or (t2 == -1))) {
		die = true;
	}
	collision();
} else {
	x += hsp;
}
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
	if (on_screen(200)) {
		if (image_index == 1){
			audio_play_sound(snd_arrow_die, 20, false, global.volume);
		}
	}
}

//destroy if leaving room
if (( t1 == -1) or (t2 == -1)) {
	instance_destroy();
}
