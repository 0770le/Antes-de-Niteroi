if ((action == true) and (((other.open == false) and (hp >0)) and (bbox_bottom <= other.bbox_bottom))) {
	with(other) {
		image_speed = 1;
		open = true;
		alarm[OPEN] = 1;
	}
	audio_play_sound(snd_open_chest, 50, false, global.volume);
	//open the door in the boss room 
	if (room == rm_02) {
		layer_set_visible(layer_get_id("Door"), true);
		show_msg("You hear a door slide open in the distance...", 3)
		audio_play_sound(snd_door_opening_closing, 90, false, global.volume);
	}
}

if ((!other.open) and (bbox_bottom == other.bbox_bottom)) {
	show_msg("press X to open", 1);
}


