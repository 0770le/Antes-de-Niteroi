/// @desc Open chest

if (image_index > 7) {
	if (gems_created < gems_to_spawn) {
		repeat(2) {
			instance_create_layer(x + random_range(-4,4),y,"gems", o_gem);
			gems_created++;
			//var pitch when spawned
			//var snd = audio_play_sound(snd_gems_spawning, 15, false, global.volume);
			//audio_sound_pitch(snd, random_range(0.9,1.1));
		}
		//time between spawns
		alarm[OPEN] = 10;
	}
} else {
	//wait
	alarm[OPEN] =1;
}








