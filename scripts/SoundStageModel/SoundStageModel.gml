#macro SOUND_STAGE_GENERAL		"general"
#macro SOUND_STAGE_SEREGIPE		"seregipe"
#macro SOUND_STAGE_RERIPE		"reripe"
#macro SOUND_STAGE_MAIN_MENU	"main_menu"
#macro SOUND_STAGE_CREDITS		"credits"

function SoundStagesModel(
	_stages = []
)
constructor 
{
	static add = function (
		_sound_stage = new SoundStageModel()) 
	{
		self[$ _sound_stage.name] = _sound_stage;
	}
	
	static update_parameter = function (
		_name = SOUND_STAGE_GENERAL, 
		_new_parameter = FMOD_PARAMETER_MUSIC_STAGE_GENERAL_VALUE.INTRO) 
	{
		self[$ _name].parameter = _new_parameter;
	}
	
	static update_event = function (
		_name = SOUND_STAGE_GENERAL, 
		_new_event = FMOD_EVENT.MENU_GENERAL) 
	{
		self[$ _name].event = _new_event;	
	}
	
	static update = function (
		_name = SOUND_STAGE_GENERAL, 
		_new_event = FMOD_EVENT.MENU_GENERAL, 
		_new_parameter = FMOD_PARAMETER_MUSIC_STAGE_GENERAL_VALUE.INTRO) 
	{
		update_event(_name, _new_event);
		update_parameter(_name, _new_parameter);
	}
	
	static init = function (_stages = [])
	{
		for (var _i = 0; _i < array_length(_stages); _i++)
		{
			add(_stages[_i]);
		}
	}
	
	init(_stages);
}

function SoundStageModel(
	_name = SOUND_STAGE_GENERAL,
	_event = FMOD_EVENT.MUSIC_GAMEPLAY_01,
	_parameter_name = FMOD_PARAMETER_NAME_MUSIC,
	_parameter_value = FMOD_PARAMETER_MUSIC_STAGE_GENERAL_VALUE.INTRO) 
constructor 
{
	name			= _name;
	event			= _event;
	parameter_name	= _parameter_name;
	parameter_value	= _parameter_value;
}
