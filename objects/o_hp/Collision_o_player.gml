
if (can_pickup) {
	with(other) {
		if (hp < o_game.max_hp) {
			hp++;
		}
		global.sound_controller.update_position_and_play(FMOD_EVENT.COLLECT_LIFE, x, y);
		global.options_controller.set_option(OPTIONS_PLAYER_HP, global.player.hp);
	}
	instance_destroy();
}

