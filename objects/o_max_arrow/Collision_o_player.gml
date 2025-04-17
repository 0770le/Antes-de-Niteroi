
if (can_pickup) {
	with(other) {
		o_game.max_arrows+= 10;
		arrows+= 10;
		//audio_play_sound(snd_pickup_hp, 15, false, global.volume);
	}
	
	global.sound_controller.update_position_and_play(FMOD_EVENT.COLLECT_ARROW_MAX, x, y);
	global.options_controller.add_to_array(OPTIONS_ARROW_UPGRADES, location);
	
	instance_destroy();
}

