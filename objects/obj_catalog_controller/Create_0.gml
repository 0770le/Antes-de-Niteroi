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