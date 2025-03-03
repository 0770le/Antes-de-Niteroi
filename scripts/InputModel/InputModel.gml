function InputDataSet (
	_input_type = INPUT_TYPE.MENU,
	_input = new MenuInputModel()) 
constructor 
{
	listeners = ds_map_create();
	input_type = _input_type;
	input = _input;
	
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
	
		for (var _i = 0; _i < array_length(_array); ++_i) 
		{
			if (input_type == INPUT_TYPE.IN_GAME)
			{
				_array[_i].on_input(input);	
			}
			else if (input_type == INPUT_TYPE.MENU)
			{
				_array[_i].on_input_menu(input);	
			}
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
}

function InGameInputModel () : InputModel ()
constructor 
{
	up				= false;
	down			= false;
	left			= false;
	right			= false;
	
	jump			= false;
	attack			= false;
}

function MenuInputModel () : InputModel ()
constructor
{
	up				= false;
	down			= false;
	left			= false;
	right			= false;
	
	toggle_menu		= false;
	toggle_catalog  = false;
	
	debug_unlock	= false;
	
	cancel			= false;
	confirm			= false;
}
