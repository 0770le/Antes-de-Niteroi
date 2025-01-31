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
		
		// player
		ATTACK_MELEE,
		ATTACK_HIT,
		WALK,
		CROUCH,
		EVADE,
		HURT,
		JUMP,
		HANG,
		DIE,
	
		//tupi melee
		TUPI_MELEE_ATK,
		TUPI_MELEE_DIE,
		TUPI_MELEE_HURT,
		
		//tupi archer
		TUPI_ARCHER_DIE,
		TUPI_ARCHER_HURT,
		
		//frances shooter
		FRENCH_SHOOTER_DIE,
		FRENCH_SHOOTER_HURT,
		
	}

#endregion

#region parameters

	#region PARAMETRO PADRÃO
	
		#macro FMOD_PARAMETER_NAME_MOVE		"move"
		
		enum FMOD_PARAMETER_MOVE_VALUE_MELEE_ATTACK
		{
			PLACE_HOLDER, GROUND_PREPARE, GROUND, MOVING, AIR
		}
		
		enum FMOD_PARAMETER_MOVE_VALUE_ATTACK_HIT
		{
			PLACE_HOLDER, MELEE_HIT, MELEE_GROUND, ARROW_GROUND, ARROW_HIT
		}
		
		enum FMOD_PARAMETER_MOVE_WALK
		{
			PLACE_HOLDER, STONE, GRASS, SAND, WOOD, DIRT, TREE, WATER
		}
		
		enum FMOD_PARAMETER_MOVE_CROUCH
		{
			PLACE_HOLDER, CROUCH, STAND
		}
		
		enum FMOD_PARAMETER_MOVE_EVADE
		{
			PLACE_HOLDER, SHORT, LONG, LAND
		}
		
		enum FMOD_PARAMETER_MOVE_JUMP
		{
			PLACE_HOLDER, JUMP, DOUBLE_JUMP, LAND
		}
		
		enum FMOD_PARAMETER_MOVE_VALUE_TUPI_MELEE_ATK
		{
			PLACE_HOLDER, PREPARE, SWING
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
		fmod_studio_system_get_num_listeners()
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

	static update_position = function(_x,_y) {
	
		var fmod_3d_att = new Fmod3DAttributes();

		fmod_3d_att.position.x = _x;
		fmod_3d_att.position.y = _y;
		
		fmod_3d_att.forward.z = -1;
		fmod_3d_att.up.y = -1;
	
		fmod_studio_event_instance_set_3d_attributes(event_instance, fmod_3d_att);
		
		var att = fmod_studio_event_instance_get_3d_attributes(event_instance)
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