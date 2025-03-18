event_inherited();

window = noone;

sub_layers = 
[
	LAYER_GUI_CATALOG, LAYER_GUI_CATALOG_BUTTONS, LAYER_GUI_CATALOG_WINDOW
]

animate = false;
animation_frame = 0;
is_open = false;

function open()
{
	window.open();
	
	is_open = true;
}

function close()
{
	window.close();
	
	is_open = false;
}

function has_new_item()
{
	return window.has_new_item();
}

function unlock_item(_catalog_item_type = CATALOG_ITEM_TYPE.ARARIBOIA)
{
	for (var _i = 0; _i < array_length(window.catalog_items); _i++)
	{
		if (window.catalog_items[_i].type == _catalog_item_type)
		{
			window.catalog_items[_i].locked = false;
			
			window.catalog_items[_i].is_new = true;
		}
	}
	
	global.options_controller.add_unlocked_item(_catalog_item_type);
}

function is_unlocked(_catalog_item_type = CATALOG_ITEM_TYPE.ARARIBOIA)
{
	for (var _i = 0; _i < array_length(window.catalog_items); _i++)
	{
		if (window.catalog_items[_i].type == _catalog_item_type)
		{
			return !window.catalog_items[_i].locked;
		}
	}
	
	return false;
}

function clear()
{
	for (var _i = 0; _i < array_length(window.catalog_items); _i++)
	{
		window.catalog_items[_i].locked = true;
		window.catalog_items[_i].is_new = false;
	}
	
	global.options_controller.clear_unlocks();
}

function create_content()
{
	window = instance_create_layer(0, 0, LAYER_GUI_CATALOG_WINDOW, obj_catalog_window);
}

function init()
{
	global.catalog_controller = self;
	
	create_content();
	
	close();
}

init();