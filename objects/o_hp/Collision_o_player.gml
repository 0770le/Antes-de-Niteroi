
if (can_pickup) {
	with(other) {
		if (hp < o_game.max_hp) {
			hp++;
		}
		global.sound_controller.play_pos(FMOD_EVENT.COLLECT_LIFE, x, y);
	}
	instance_destroy();
}

