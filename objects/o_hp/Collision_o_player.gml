
if (can_pickup) {
	with(other) {
		if (hp < o_game.max_hp) {
			hp++;
		}
		global.sound_controller.update_position_and_play(FMOD_EVENT.COLLECT_LIFE, x, y);
	}
	instance_destroy();
}

