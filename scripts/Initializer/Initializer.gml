function Initializer () 
constructor
{
	static init = function () 
	{
		instance_create_layer(0, 0, LAYER_CONTROLLERS, obj_input_manager);
		instance_create_layer(0, 0, LAYER_CONTROLLERS, obj_options_controller);
		instance_create_layer(0, 0, LAYER_CONTROLLERS, obj_menu_controller);
		
		global.initializer = self;
	}
	
	init();
}

global.initializer = undefined;
