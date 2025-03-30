
if (can_pickup) {
	with(other) {
		if (arrows < o_game.max_arrows) {
			arrows++;
		}
		//audio_play_sound(snd_pickup_hp, 15, false, global.volume);
	}
	instance_destroy();
}

