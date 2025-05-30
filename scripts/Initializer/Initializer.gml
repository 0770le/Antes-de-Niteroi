function Initializer () 
constructor
{
	creation_order = [ obj_input_manager, obj_options_controller, obj_menu_controller, obj_catalog_controller ]	
	always_actives = [ obj_input_manager, obj_options_controller, o_sound_controller ]
	mutually_exclusives = [	obj_menu_controller, obj_catalog_controller	]
	
	static focus = function (_object_index = obj_menu_controller)
	{
		if (_object_index == noone) 
		{
			instance_activate_all();
			
			for (var _i = 0; _i < array_length(mutually_exclusives); _i++)
			{
				with(mutually_exclusives[_i])
				{
					hide_all();
				}
				
				instance_deactivate_object(mutually_exclusives[_i]);
			}
		}
		else 
		{
			instance_deactivate_all(true);
			
			// deactivate mutually exclusive		
			for (var _i = 0; _i < array_length(mutually_exclusives); _i++)
			{
				if (_object_index != mutually_exclusives[_i])
				{
					with(mutually_exclusives[_i]) 
					{
						hide_all();
					}
				
					instance_deactivate_object(mutually_exclusives[_i]);
				}
			}
		
			// reactivate objects that cannot be deactivated
			for (var _i = 0; _i < array_length(always_actives); _i++)
			{
				instance_activate_object(always_actives[_i]);
			}
		
			// reactivate focused object
			instance_activate_object(_object_index);
		}
	}
	
	static init = function () 
	{
		global.initializer = self;
		
		for (var _i = 0; _i < array_length(creation_order); _i++)
		{			
			instance_create_layer(0, 0, LAYER_CONTROLLERS, creation_order[_i]);
		}
	}
	
	init();
}

global.initializer = undefined;
