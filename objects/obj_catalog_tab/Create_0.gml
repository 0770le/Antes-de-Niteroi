event_inherited();

image_yscale	= 0.5;
image_xscale	= 0.6;
label			= "Placeholder";
font			= fnt_arial_medium;
previous		= self;
next			= self;

items			= [];
selected_item   = noone;

max_display_items = 8;
min_display_index = 0;
max_display_index = 0;

first_item_x	= 54.5;
first_item_y	= 138.5;

item_margin_x	= 0;
item_margin_y	= 30;

function update_cursor(_previous_index, _current_index)
{
	if (_current_index < _previous_index)
	{
		if (_current_index < min_display_index)
		{
			var _delta = min_display_index - _current_index;
			
			min_display_index = _current_index;
			max_display_index -= _delta;
			
			toggle_items(true);
		}
	}
	else if (_current_index > _previous_index)
	{
		if (_current_index > max_display_index)
		{
			var _delta = _current_index - max_display_index;
			
			min_display_index += _delta;
			max_display_index = _current_index;
			
			toggle_items(true);
		}
	}
}

function update_items_position()
{
	
}

function set_selected(_selected = false) 
{
	image_index	= _selected ? 0 : 1;
	
	toggle_items(_selected);
}

function has_new_item()
{
	for (var _i = 0; _i < array_length(items); ++_i) 
	{
		if (items[_i].is_new) return true;    
	}
	
	return false;
}

function draw() 
{
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	draw_set_color(c_white);
	draw_set_font(font);
	
	var _xx = get_sprite_center_x();
	var _yy = get_sprite_center_y();
	
	draw_text(_xx, _yy, label);
	
	if (has_new_item())
	{
		draw_sprite_ext(spr_catalog_new_item, 0, bbox_right - 15, _yy, 0.35, 0.35, 0, c_white, 1);
	}
}

function add_item(_item = noone)
{
	_item.index = array_length(items);
	
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
	_item.parent_tab = self;
	
	array_push(items, _item);
	
	max_display_index = min(max_display_items - 1, _item.index);
	
	_item.x = first_item_x;
	_item.y = first_item_y + ((sprite_get_height(_item.sprite_index) + item_margin_y) * _item.index);
	
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
		if (_i >= min_display_index && _i <= max_display_index)
		{
			items[_i].visible = _visible;
			
			items[_i].y = first_item_y + ((sprite_get_height(items[_i].sprite_index) + item_margin_y) * (_i-min_display_index));
		}
		else 
		{
			items[_i].visible = false;
		}
	}
}