
if (can_pickup) {
	with(other) {
		if (lives < o_game.max_lives) {
			lives++;
		}
		//audio_play_sound(snd_pickup_hp, 15, false, global.volume);
	}
	instance_destroy();
}

