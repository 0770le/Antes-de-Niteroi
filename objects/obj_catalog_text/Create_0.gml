font = fnt_arial_small;
text = "Placeholder";
valign = fa_top;
halign = fa_left;
color = c_black;

function get_text_witdh()
{
	draw_set_font(font);
	
	return string_width(text);
}

function get_text_height()
{
	draw_set_font(font);
	
	return string_width(text);
}

function draw()
{
	draw_set_font(font);
	draw_set_valign(valign);
	draw_set_halign(halign);
	draw_set_color(color);
	
	draw_text(x, y, text);
}