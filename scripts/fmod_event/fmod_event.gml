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
		CIDADE_VELHA_ROOM_AMBIENCE,
		CIDADE_VELHA_SEA_AMBIENCE,
		
		// player
		ATTACK_MELEE,
		ATTACK_HIT,
		ATTACK_BOW,
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
		TUPI_MELEE_JUMP,
		TUPI_MELEE_EVADE,
		TUPI_MELEE_WALK,
		
		//tupi archer
		TUPI_ARCHER_DIE,
		TUPI_ARCHER_HURT,
		TUPI_ARCHER_ATTACK,
		
		//frances shooter
		FRENCH_SHOOTER_DIE,
		FRENCH_SHOOTER_HURT,
		FRENCH_SHOOTER_COUCH,
		FRENCH_SHOOTER_JUMP,
		FRENCH_SHOOTER_RELOAD,
		FRENCH_SHOOTER_SHOOT,		
		
		//armadeira
		SPIDER_DIE,
		SPIDER_HURT,
		SPIDER_ATTACK,
		
		//jararaca
		SNAKE_DIE,
		SNAKE_HURT,
		
		// UI
		BUTTON_TALK,
		COLLECT_LIFE,
		COLLECT_REGISTER,
		TRANSITION_BOAT,
		
		// wood barrier
		WOOD_BARRIER_BREAK,
		WOOD_BARRIER_DEBRIS,
		
		// CHEVALIER
		CHEVALIER_ATTACK_SHIELD,
		CHEVALIER_ATTACK_SPEAR_PIERCE,
		CHEVALIER_ATTACK_SPEAR_SLASH,
		CHEVALIER_DEATH,
		CHEVALIER_GUARD,
		CHEVALIER_HURT,
		CHEVALIER_TURN,
		CHEVALIER_WALK,
		
		// HARPIA
		HARPIA_ATTACK,
		HARPIA_DIE,
		HARPIA_FLAP,
		HARPIA_HURT,
		HARPIA_IDLE
	}

#endregion

#region parameters

	#region PARAMETRO PADRÃO
	
		#macro FMOD_PARAMETER_NAME_MOVE		"move"
		#macro FMOD_PARAMETER_NAME_MUSIC	"music"
		
		enum FMOD_PARAMETER_MUSIC_VALUE
		{
			PLACE_HOLDER, INTRO, ENGAGE_FIRST_ENEMY, SIDE_ROOMS
		}
		
		enum FMOD_PARAMETER_MOVE_VALUE_MELEE_ATTACK
		{
			PLACE_HOLDER, GROUND_PREPARE, GROUND, MOVING, AIR
		}
		
		enum FMOD_PARAMETER_MOVE_VALUE_ATTACK_HIT
		{
			PLACE_HOLDER, MELEE_HIT, MELEE_GROUND, ARROW_GROUND, ARROW_HIT
		}
		
		enum FMOD_PARAMETER_ATTACK_BOW_VALUE
		{
			PLACE_HOLDER, PREPARE, RELEASE
		}
		
		enum FMOD_PARAMETER_MOVE_WALK
		{
			PLACE_HOLDER, STONE, GRASS, SAND, WOOD, DIRT, WATER
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
		
		enum FMOD_PARAMETER_MOVE_VALUE_WOOD_BREAK
		{
			PLACE_HOLDER, HIT, BREAK
		}
		
		enum FMOD_PARAMETER_VALUE_TUPI_ARCHER_ATTACK
		{
			PLACE_HOLDER, PREPARE, RELEASE
		}
		
		enum FMOD_PARAMETER_VALUE_TUPI_MELEE_JUMP
		{
			PLACE_HOLDER, JUMP, LAND
		}
		
		enum FMOD_PARAMETER_VALUE_FRENCH_SHOOTER_JUMP 
		{
			PLACE_HOLDER, JUMP, LAND
		}
		
	#endregion

#endregion

function FmodEvent(_event_path = "event:/SFX/AMBIENCE WEATHER/ambience weather",
				   _parameters = []) 
constructor 
{
	event_path			= _event_path;
	event_instance		= noone;
	event_description	= noone;
	parameters			= _parameters;
	sound_group			= noone;
	fmod_3d_att			= new Fmod3DAttributes();
	is_spacial			= false;
	listening_radius    = 200;
	
	parameters_by_name	= ds_map_create();
	
	static play = function ()
	{
		if (!is_spacial || point_distance(fmod_3d_att.position.x, fmod_3d_att.position.y, global.sound_controller.fmod_3d_att.position.x, global.sound_controller.fmod_3d_att.position.y) < 200) {
			fmod_studio_event_instance_start(event_instance);
			
			global.logger.debug($"FmodEvent playing: {event_path} source.x:{fmod_3d_att.position.x}, source.y:{fmod_3d_att.position.y}, listener.x:{global.sound_controller.fmod_3d_att.position.x}, listener.y:{global.sound_controller.fmod_3d_att.position.y}, number_of_listeners: {fmod_studio_system_get_num_listeners()}, distance: {point_distance(fmod_3d_att.position.x, fmod_3d_att.position.y, global.sound_controller.fmod_3d_att.position.x, global.sound_controller.fmod_3d_att.position.y)}");
		}
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
	
	static update_parameter = function (_name = "time lapse", _label = FMOD_PARAMETER_MOVE_JUMP.JUMP)
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
	
		is_spacial = true;
	
		fmod_3d_att.position.x = _x;
		fmod_3d_att.position.y = _y;
		
		fmod_3d_att.forward.z = -1;
		fmod_3d_att.up.y = -1;
	
		fmod_studio_event_instance_set_3d_attributes(event_instance, fmod_3d_att);
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