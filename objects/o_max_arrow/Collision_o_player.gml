
if (can_pickup) {
	with(other) {
		o_game.max_arrows+= 10;
		arrows+= 10;
		//audio_play_sound(snd_pickup_hp, 15, false, global.volume);
	}
	instance_destroy();
}

