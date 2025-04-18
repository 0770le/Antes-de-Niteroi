
if (can_pickup) {
	with(other) {
		hp = o_game.max_hp;
	}
	global.sound_controller.update_position_and_play(FMOD_EVENT.COLLECT_LIFE_FULL, x, y);
	global.options_controller.set_option(OPTIONS_PLAYER_HP, global.player.hp);
	instance_destroy();
}

