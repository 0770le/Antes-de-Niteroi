// window
layer_text		= LAYER_GUI_CATALOG_BUTTONS;
catalog_text	= noone;
image_xscale	= 4;

// text
font			= fnt_arial_small;
text			= "Placeholder";
valign			= fa_top;
halign			= fa_left;
color			= c_black;

// selection
is_selected		= false;
is_hovered		= false;

function set_hover(_hover = false)
{
	is_hovered = _hover;
	
	image_index = is_hovered ? 1 : 0;
}

function set_selected(_select = false)
{
	
}

function draw()
{
	// background
	if (!is_hovered)
	{
		draw_self();
	}
	else 
	{
		draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, 0, c_gray, 1);
	}
	
	// text
	draw_set_font(font);
	draw_set_valign(valign);
	draw_set_halign(halign);
	draw_set_color(color);
	
	draw_text(x, y, text);
}