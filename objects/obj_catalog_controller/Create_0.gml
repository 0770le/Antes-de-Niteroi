x					= 320;
y					= 180;
image_xscale		= 16 / 2;
image_yscale		= 9 / 2;
is_open				= false;

function open()
{
	is_open = true;
	
	global.menu_controller.close();
	
	global.initializer.focus(object_index);
}

function close()
{
	instance_activate_all();
	
	is_open = false;
}

function on_input_menu(_input = new MenuInputModel())
{
	if (!is_open)
	{
		if (_input.toggle_catalog) 
		{
			open();
		} 
		
		return;
	}
	
	if (_input.toggle_catalog) close();
}

function init()
{
	global.catalog_controller = self;
	global.input_manager.subscribe(self, INPUT_TYPE.MENU);
}

init();