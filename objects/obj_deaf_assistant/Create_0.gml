global.deaf_assistant = self;

// settings 

display_period_max		= 180;
fading_period			= 60;
left_position_marker	= "<";
right_position_marker	= ">";
marker_threshold		= 80;
max_markers				= 3;

// controls

is_active				= false;
display_period			= 0;
captions				= "Hello, world!";

function show_captions_pos(_captions = "Hello, World!", _emitter_x = x)
{
	var _is_enabled = global.options_controller.get_option(OPTIONS_DEAF_ASSISTANCE);
	
	if (_is_enabled) 
	{
		var _message = global.i18n.get_message(_captions);
		
		_captions = get_captions_with_markers(_message, _emitter_x);
	
		show_captions(_captions);
	}
}

function show_captions(_captions = "Hello, World!") 
{
	var _is_enabled = global.options_controller.get_option(OPTIONS_DEAF_ASSISTANCE);
	
	if (_is_enabled)
	{
		display_period = display_period_max;
		captions	   = _captions;
	}
}

function get_captions_with_markers(_captions, _emitter_x)
{
	var _listener = global.sound_controller.get_listener();
	
	var _distance = abs(_listener.position.x - _emitter_x);
	var _is_left = sign(_listener.position.x - _emitter_x);
	var _position_marker = _is_left ? left_position_marker : right_position_marker;
	var _quantity = min(floor(_distance / marker_threshold), max_markers);
	
	if (_quantity > 0)
	{
		if (_is_left)
		{
			_captions = " " + _captions;
		}
		else 
		{
			_captions = _captions + " ";
		}
	}
	
	repeat (_quantity) 
	{
		if (_is_left)
		{
			_captions = _position_marker + _captions;
		}
		else 
		{
			_captions = _captions + _position_marker;
		}
	}
	
	return _captions;
}

function debug()
{
	if (keyboard_check_pressed(ord("M")))
	{
		show_captions($"Hello, World! {current_time}")
	}
	else if (keyboard_check_pressed(ord("N"))) 
	{
		show_captions_pos($"Hello, World! {current_time}", 600, 0);
	}
}

function draw()
{
	if (display_period == 0) return;
	
	var _alpha = display_period >= fading_period
			? 1 
			: display_period / fading_period
	
	draw_set_valign(fa_middle);
	draw_set_halign(fa_center);
	draw_set_font(fnt_arial_medium);
	
	var _xx = window_get_width() / 2;
	var _yy = window_get_height() - 60;
	
	// draw background
	draw_set_alpha(_alpha / 2);
	draw_set_color(c_black);
	draw_rectangle(
		_xx - (string_width(captions) / 2) - 20, _yy - (string_height(captions) / 2) - 20, 
		_xx + (string_width(captions) / 2) + 20, _yy + (string_height(captions) / 2) + 20,
		false
	);
	
	// draw text
	draw_set_alpha(_alpha);
	draw_set_color(c_white);
	draw_text(_xx, _yy, captions);
	
	display_period--;
}
