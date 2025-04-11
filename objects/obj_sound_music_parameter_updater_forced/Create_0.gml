sound_stage_name = SOUND_STAGE_GENERAL;
parameter_value = FMOD_PARAMETER_MUSIC_STAGE_GENERAL_VALUE.ENGAGE_FIRST_ENEMY;

function update_parameter() 
{
	var _sound_stage = global.options_controller.get_sound_stage(sound_stage_name);
	
	if (_sound_stage.parameter_value != parameter_value)
	{
		global.options_controller.set_sound_stage_parameter(sound_stage_name, parameter_value);	
	
		global.sound_controller.update_event_parameter(
			_sound_stage.event, 
			_sound_stage.parameter_name, 
			parameter_value
		);
	}
}
