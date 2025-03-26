new_music_parameter_value = FMOD_PARAMETER_MUSIC_VALUE.ENGAGE_FIRST_ENEMY;

function update_parameter() {
	if (global.options_controller.get_option(OPTIONS_MUSIC_PARAMETER) < new_music_parameter_value) {
		global.options_controller.set_option(OPTIONS_MUSIC_PARAMETER, new_music_parameter_value);
		
		global.sound_controller.update_event_parameter(
			FMOD_EVENT.MUSIC_GAMEPLAY, 
			FMOD_PARAMETER_NAME_MUSIC,
			new_music_parameter_value
		);
	}
}