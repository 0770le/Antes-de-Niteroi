// window
event_inherited();

layer_text		= LAYER_GUI_CATALOG_BUTTONS;

catalog_text	= noone;
image_xscale	= 2;
image_yscale	= 0.5;
top_y			= bbox_top;

// text
font			= fnt_arial_small;
label			= "Label";
text			= "Placeholder";
image			= spr_catalog_image;
valign			= fa_middle;
halign			= fa_left;
color			= c_black;

previous		= self;
next			= self;

// selection
is_selected		= false;
is_hovered		= false;

function set_hover(_hover = false)
{
	is_hovered = _hover;
	
	image_index = is_hovered ? 0 : 1;
}

function draw()
{
	// background
	draw_self();
	
	// label
	draw_set_font(font);
	draw_set_valign(valign);
	draw_set_halign(halign);
	draw_set_color(color);
	
	draw_text(x + 10, get_sprite_center_y(), label);
	
	// image
	if (image_index == 1) return; // not active
	
	draw_sprite(image, 0, bbox_right + 2, top_y + 5);
	
	var _xx = bbox_right + sprite_get_width(image) + 10;
	
	draw_set_valign(fa_top);
	draw_set_halign(fa_left);
	draw_set_font(fnt_arial_very_small);
	
	draw_text_ext(_xx, top_y + 10, text, 15, 300);
}