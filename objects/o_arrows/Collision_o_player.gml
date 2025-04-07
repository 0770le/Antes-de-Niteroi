
if (can_pickup) {
	with(other) {
		arrows = min(arrows + 5, o_game.max_arrows);
		//audio_play_sound(snd_pickup_hp, 15, false, global.volume);
	}
	instance_destroy();
}

