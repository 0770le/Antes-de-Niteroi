/// @descr

is_selected			= false;
selection_sprite	= s_pointer;
selection_image		= 0;
label				= "Hello, my dude!";
font				= fnt_arial_medium_to_small;
color				= c_black;
valign				= fa_top;
halign				= fa_left;

function on_click()
{
	
}

function set_selected(_is_selected = true)
{
	is_selected = _is_selected;
}

function draw_gui()
{
	draw_self();
	
	draw_set_color(color);
	draw_set_halign(halign);
	draw_set_valign(valign);
	draw_set_font(font);
	
	draw_text(x, y, label);	
	
	if (is_selected)
	{
		draw_sprite(selection_sprite, selection_image, x - 32, y - 6);
	}
}