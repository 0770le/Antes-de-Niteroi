
if (can_pickup) {
	with(other) {
		o_game.max_hp++
		hp++;
		update_saved_hp();
		//audio_play_sound(snd_pickup_hp, 15, false, global.volume);
	}
	
	global.sound_controller.update_position_and_play(FMOD_EVENT.COLLECT_LIFE_MAX, x, y);
	global.options_controller.add_to_array(OPTIONS_HP_UPGRADES, location);
	
	instance_destroy();
}

