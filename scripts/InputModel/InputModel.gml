function InputDataSet (
	_input_type = INPUT_TYPE.MENU,
	_input = new MenuInputModel(),
	_menu_item = undefined) 
constructor 
{
	listeners = ds_map_create();
	input_type = _input_type;
	input = _input;
	menu_item = _menu_item;
	
	static subscribe = function (_object = noone) 
	{
		listeners[? _object.id] = _object;
	}

	static unsubscribe = function (_object = noone)
	{
		ds_map_delete(listeners, _object.id);
	}

	static notify = function ()
	{
		var _array = ds_map_values_to_array(listeners, []);
		var _all_closed = true;
	
		for (var _i = 0; _i < array_length(_array); ++_i) 
		{
			if (input_type == INPUT_TYPE.IN_GAME)
			{
				_array[_i].on_input(input);	
			}
			else if (input_type == INPUT_TYPE.MENU)
			{
				if (_array[_i].is_open)
				{
					_array[_i].on_input_menu(input);	
					
					_all_closed = false;
					
					break;
				}
			}
			else if (input_type == INPUT_TYPE.KEY_MAP)
			{
				_array[_i].on_input_key_map(menu_item, input);	
			}
		}
		
		if (_all_closed && input_type == INPUT_TYPE.MENU) 
		{
			global.menu_controller.on_input_menu(input);
		}
	}
}

function InputModel () 
constructor 
{
	static any = function () 
	{
		var _properties = variable_struct_get_names(self);
		
		for (var _i = 0; _i < array_length(_properties); ++_i) 
		{
			if (self[$ _properties[_i]]) 
			{
				return true;
			}
		}
		
		return false;
	}
	
	static clear = function ()
	{
		var _properties = variable_struct_get_names(self);
		
		for (var _i = 0; _i < array_length(_properties); ++_i) 
		{
			self[$ _properties[_i]] = false;
		}
	}
}

function InGameInputModel () : InputModel ()
constructor 
{
	up				= false;
	down			= false;
	left			= false;
	right			= false;
	
	up_camera		= false;
	down_camera		= false;
	left_camera		= false;
	right_camera	= false;
	
	jump			= false;
	attack			= false;
	dodge			= false;
	bow_shot		= false;
	interact		= false;
	
	jump_held		= false;
	attack_held		= false;
	dodge_held		= false;
	bow_shot_held	= false;
	interact_help	= false;
}

function MenuInputModel () : InputModel ()
constructor
{
	up				= false;
	up_held			= false;
	down			= false;
	down_held		= false;
	left			= false;
	left_held		= false;
	right			= false;
	right_held		= false;
	
	toggle_menu		= false;
	toggle_catalog  = false;
	
	debug_unlock	= false;
	debug_clear		= false;
	
	cancel			= false;
	confirm			= false;
	
	page_up 		= false;
	page_down		= false;
	
	tab_left 		= false;
	tab_right		= false;
	
	change_language = false;
}

function KeyMapInputModel () : InputModel ()
constructor
{
	cancel			= false;
	key_pressed		= false;
}