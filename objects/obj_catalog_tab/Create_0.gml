event_inherited();

image_yscale	= 1.5;
image_xscale	= 4;
label			= "Placeholder";
font			= fnt_arial_medium;
previous		= self;
next			= self;

items			= [];
selected_item   = noone;

function set_selected(_selected = false) 
{
	image_index	= _selected ? 0 : 1;
	
	toggle_items(_selected);
}

function draw() 
{
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	draw_set_color(c_black);
	draw_set_font(font);
	
	var _xx = get_sprite_center_x();
	var _yy = get_sprite_center_y();
	
	draw_text(_xx, _yy, label);
}

function add_item(_item = noone)
{
	if (array_length(items) == 0)
	{
		selected_item = _item;
		_item.set_hover(true);
	}
	else 
	{
		var _last_item = items[array_length(items) - 1];
		_last_item.next = _item;
		_item.previous = _last_item;
		_item.set_hover(false);
	}
	
	_item.top_y = bbox_bottom;
	
	array_push(items, _item);
	
	return _item;
}

function add_items(_items = [])
{
	for (var _i = 0; _i < array_length(_items); _i++)
	{
		add_item(_items[_i]);
	}

}

function toggle_items(_visible = false)
{
	for (var _i = 0; _i < array_length(items); _i++)
	{
		items[_i].visible = _visible; 
	}

}