event_inherited();

window = noone;

sub_layers = 
[
	LAYER_GUI_CATALOG, LAYER_GUI_CATALOG_BUTTONS, LAYER_GUI_CATALOG_WINDOW
]

function open()
{
	window.open();
}

function close()
{
	window.close();
}

function unlock_item(_catalog_item_type = CATALOG_ITEM_TYPE.ARARIBOIA)
{
	with (obj_catalog_item)
	{
		if (type == _catalog_item_type)
		{
			locked = false;
		}
	}
	
	global.options_controller.add_unlocked_item(_catalog_item_type);
}

function on_options_change(_options_model = new OptionsModel()) 
{
	with (obj_catalog_item)
	{
		if (array_contains(_options_model.unlocked_catalog_items, type))
		{
			locked = false;
		}
	}
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