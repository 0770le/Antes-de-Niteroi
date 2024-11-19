//tiles
//get tile map
global.map = layer_tilemap_get_id("collisions");
global.tile_size = TILE_SIZE;

//player create
if (( (room!= rm_init) and (room != rm_menu) ) and (!instance_exists(o_player) ) ) {
	instance_create_layer(x,y, "Player", o_player);
}

//cancel any messages
alarm[DISPLAY_MSG] = 0;

////play music
//if (room == rm_menu) {
//	//stop game music
//	audio_stop_sound(snd_mus_middle_park)
//	//play end game music
//	audio_play_sound(snd_mus_game_end, 10, false);
//} else {
//	//play game music
//	if (!audio_is_playing(snd_mus_middle_park)){
//		audio_play_sound(snd_mus_middle_park, 20, true);
//	}
//}