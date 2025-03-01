sub_layers = [];

function hide_all()
{
	for (var _i = 0; _i < array_length(sub_layers); ++_i) 
	{
		instance_deactivate_layer(sub_layers[_i]);
	}
}

function show_all()
{
	for (var _i = 0; _i < array_length(sub_layers); ++_i) 
	{
		instance_activate_layer(sub_layers[_i]);
	}
}

function get_sprite_center_x()
{
	return ((bbox_right - bbox_left)/2) + bbox_left;
}

function get_sprite_center_y()
{
	return ((bbox_bottom - bbox_top)/2) + bbox_top;
}
