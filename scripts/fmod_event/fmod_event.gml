#region bus

enum FMOD_BUS
{
	MASTER
}

#endregion

#region vcas

enum FMOD_VCA
{
	MUSIC, 
	SFX
}

#endregion

#region events

	enum FMOD_EVENT
	{
		// loops
		
		MUSIC_GAMEPLAY,
		MUSIC_MENU,
		WEATHER_AMBIENCE,
		
		// hovers
	
		HOVER_BUTTON_MENU_START_SCREEN,
		HOVER_BUTTON_MENU_INTERNAL, // options inside menus
		HOVER_BUTTON_GENERAL, // time machine, tools, infos and confirm dialogs // TODO check challenge option hover
		
		// clicks
		
		CLICK_BUTTON_MENU_START_SCREEN,
		CLICK_BUTTON_TIME_MACHINE,
		CLICK_BUTTON_INFOS_CHALLENGE_OPTION_AND_INTERNALS, // the internals of this section
		CLICK_BUTTON_TOOLS_AND_CONFIRMATION_DIALOGS, // tools and confirm dialogs, mouse right-click (unselect)
		CLICK_TAB_CATALOG,
		
		// perform actions
		
		ACTION_SELECT_SEED,
		ACTION_SELECT_SOIL,
		ACTION_TOOL_HARVEST,		
		ACTION_TOOL_PLANT,
		ACTION_TOOL_PLOW,
		ACTION_TOOL_REMOVE,
		ACTION_TOOL_WATER,
		ACTION_TOOL_CLEAN,
				
		// notifications
		
		NOTIFICATION_GENERAL,
		NOTIFICATION_QUEST_COMPLETE,
		NOTIFICATION_CHALLENGE_ANSWER,
		NOTIFICATION_GAME_BEAT,
		NOTIFICATION_GAME_WIN_OR_LOSE,
		
		// game actions
		
		GAME_EXIT_TO_DESKTOP_OR_START_SCREEN,
		GAME_NEW_OR_LOAD,
		
		// challenges
		
		CHALLENGE_SHOW
	}

#endregion

#region parameters

	#region notification game win or lose parameters
	
		#macro FMOD_PARAMETER_NAME_WIN_LOSE		"win-lose"
		
		enum FMOD_PARAMETER_WIN_LOSE
		{
			PLACE_HOLDER, WIN, LOSE
		}
	
	#endregion

	#region ambiente weather parameters

		#macro FMOD_PARAMETER_NAME_TIME_LAPSE	"time lapse" 
		#macro FMOD_PARAMETER_NAME_RAIN			"rain" 
		#macro FMOD_PARAMETER_NAME_DAY_NIGHT	"day - night" 
		#macro FMOD_PARAMETER_NAME_STOP_TIME	"stop time" 

		enum FMOD_PARAMETER_TIME_LAPSE
		{
			PLACE_HOLDER, NORMAL, FASTER, FASTEST
		}

		enum FMOD_PARAMETER_RAIN
		{
			PLACE_HOLDER, NOT_RAINING, RAINING
		}

		enum FMOD_PARAMETER_DAY_NIGHT
		{
			PLACE_HOLDER, DAY, NIGHT
		}

		enum FMOD_PARAMETER_STOP_TIME 
		{
			PLACE_HOLDER, NORMAL, PAUSED
		}

	#endregion

	#region time machine buttons

		#macro FMOD_PARAMETER_NAME_TIME_MACHINE "time machine" 

		enum FMOD_PARAMETER_TIME_MACHINE 
		{
			PLACE_HOLDER,
			NORMAL,
			FASTER,
			FASTEST,
			STOP
		}

	#endregion

	#region seeds icon

		#macro FMOD_PARAMETER_NAME_PANTRY	"pantry" 

	#endregion
	
	#region button tools
	
		#macro FMOD_PARAMETER_NAME_BUTTON_TOOLS	"pantry" 
		
		enum FMOD_PARAMETER_BUTTON_TOOLS
		{
			PLACE_HOLDER, SELECT, UNSELECT
		}

	#region crop seed action

		#macro FMOD_PARAMETER_NAME_HOLD_RELEASE_FORBIDDEN	"hold-release-forbiden" 

		enum FMOD_PARAMETER_HOLD_RELEASE_FORBIDDEN
		{
			PLACE_HOLDER, HOLD, RELEASE, FORBIDDEN
		}

	#endregion

	#region plow action

		#macro FMOD_PARAMETER_NAME_PLOW_HOLD_RELEASE	"hold - release" 

		enum FMOD_PARAMETER_PLOW_HOLD_RELEASE
		{
			PLACE_HOLDER, HOLD, RELEASE
		}

	#endregion

	#region open close basic

		#macro FMOD_PARAMETER_NAME_OPEN_CLOSE_BASIC	"open-close" 

		enum FMOD_PARAMETER_OPEN_CLOSE_BASIC
		{
			PLACE_HOLDER, OPEN, CLOSE
		}

	#endregion

#endregion

function FmodEvent(_event_path = "event:/SFX/AMBIENCE WEATHER/ambience weather",
				   _parameters = 
					[
						new FmodParameter("time lapse", [FMOD_PARAMETER_TIME_LAPSE.NORMAL, FMOD_PARAMETER_TIME_LAPSE.FASTER, FMOD_PARAMETER_TIME_LAPSE.FASTEST]),
						new FmodParameter("rain", [FMOD_PARAMETER_RAIN.NOT_RAINING, FMOD_PARAMETER_RAIN.RAINING]),
						new FmodParameter("day - night", [FMOD_PARAMETER_DAY_NIGHT.DAY, FMOD_PARAMETER_DAY_NIGHT.NIGHT]),
						new FmodParameter("stop time", [FMOD_PARAMETER_STOP_TIME.NORMAL, FMOD_PARAMETER_STOP_TIME.PAUSED])
					]) 
constructor 
{
	event_path			= _event_path;
	event_instance		= noone;
	event_description	= noone;
	parameters			= _parameters;
	sound_group			= noone;
	
	parameters_by_name	= ds_map_create();
	
	static play = function ()
	{
		fmod_studio_event_instance_start(event_instance);
	}
	
	static stop = function ()
	{
		fmod_studio_event_instance_stop(event_instance, FMOD_STUDIO_STOP_MODE.IMMEDIATE);
	}
	
	static set_sound_group = function (_sound_group_ref) 
	{
		sound_group = _sound_group_ref;
	}
	
	static set_volume = function (_volume = 1)
	{
		fmod_studio_event_instance_set_volume(event_instance, _volume);
	}
	
	static update_parameter = function (_name = "time lapse", _label = FMOD_PARAMETER_TIME_LAPSE.NORMAL)
	{
		parameters_by_name[? _name].update(_label);
	}
	
	static fill_parameters_by_name = function ()
	{
		for (var _i = 0; _i < array_length(parameters); _i++)
		{
			var _parameter = parameters[_i];
			
			parameters_by_name[? _parameter.name] = _parameter;	 
		}
	}
	
	static init = function () 
	{
		fill_parameters_by_name();
		
		event_description	= fmod_studio_system_get_event(event_path);
		event_instance		= fmod_studio_event_description_create_instance(event_description);
		
		for (var _i = 0; _i < array_length(parameters); _i++)
		{
			var _parameter = parameters[_i];
			
			var _parameter_description = fmod_studio_event_description_get_parameter_description_by_name(event_description, _parameter.name);
			
			_parameter.set_event_instance(event_instance);
			_parameter.set_parameter_description(_parameter_description);
			_parameter.init();
		}

	}
	
	init();
}

function FmodParameter(_name	= "time lapse",
					   _labels	= [FMOD_PARAMETER_TIME_LAPSE.NORMAL, FMOD_PARAMETER_TIME_LAPSE.FASTER, FMOD_PARAMETER_TIME_LAPSE.FASTEST])
constructor
{
	name					= _name;
	labels					= _labels;
	event_instance			= noone;
	parameter_description	= noone;
	current_label			= 1;
	
	static update = function (_label = FMOD_PARAMETER_TIME_LAPSE.NORMAL)
	{
		if (current_label != _label)
		{
			fmod_studio_event_instance_set_parameter_by_name(event_instance, name, _label, true);
		
			current_label = _label;
		}
	}
	
	static set_event_instance = function (_event_instance = noone)
	{
		event_instance = _event_instance;
	}
	
	static set_parameter_description = function (_parameter_description = noone)
	{
		parameter_description = _parameter_description;
	}
	
	static init = function ()
	{
		update(labels[0]);
	}
}