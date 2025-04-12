// settings

captions			= "PlaceHolder";
display_period_max	= 180;
fading_period       = 60;

// controls

show				= false;
display_period_max	= 180;
display_period		= 0;
fading_period       = 60;
already_shown		= false;

function show_captions_forced()
{
	already_shown = false;
	
	show_captions();
}

function show_captions() 
{
	if (already_shown) return;
	
	var _was_showing = show;
	
	show = global.options_controller.get_option(OPTIONS_DEAF_ASSISTANCE);
	
	if (!_was_showing && show)
	{
		display_period = display_period_max;
		
		already_shown = true;
	}
}

function draw()
{
	if (!show || display_period == 0) return;
	
	var _alpha = display_period > (display_period_max - fading_period) 
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
}
