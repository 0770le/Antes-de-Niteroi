
if (can_pickup) {
	with(other) {
		arrows = min(arrows + 5, o_game.max_arrows);
		//audio_play_sound(snd_pickup_hp, 15, false, global.volume);
	}
	
	global.sound_controller.update_position_and_play(FMOD_EVENT.COLLECT_ARROW, x, y);
	global.options_controller.set_option(OPTIONS_PLAYER_ARROWS, global.player.arrows);	
	
	instance_destroy();
}

