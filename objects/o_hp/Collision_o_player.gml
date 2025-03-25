
if (can_pickup) {
	with(other) {
		if (hp < o_game.max_hp) {
			hp++;
		}
		audio_play_sound(snd_pickup_hp, 15, false, global.volume);
	}
	instance_destroy();
}

