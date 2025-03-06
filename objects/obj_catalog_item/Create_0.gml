// window
event_inherited();

enum CATALOG_ITEM_TYPE
{
	UNSET,
	ARARIBOIA,
	ARARA_CANINDE,
	ARMADEIRA,
	BARQUEIRO,
	FRANCES,
	CIDADE_VELHA,
	MORUBIXABA,
	KUNUMIUASU,
	MUCURANA
}

layer_text		= LAYER_GUI_CATALOG_BUTTONS;
type			= CATALOG_ITEM_TYPE.ARARIBOIA;

catalog_text	= noone;
image_xscale	= 1.2;
image_yscale	= 1.2;
top_y			= bbox_top;
locked			= true;

// text
font			= fnt_arial_medium;
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

frame_color     = make_color_rgb(109, 89, 68);

// scroll text
line_separation = 30;
height_max		= 360;
line_width		= 480;
text_parts		= [];
text_shown		= "";
cursor			= 0;
cursor_max		= 0;
page_length     = 0;
is_new			= false;
parent_tab		= noone;

function set_hover(_hover = false)
{
	is_hovered = _hover;
	
	image_index = is_hovered ? 0 : 1;
	
	if (!_hover) cursor = 0;
}

function previous_page()
{
	cursor = max(0, cursor - 1);
}

function next_page()
{
	cursor = min(cursor + 1, cursor_max);
}

function set_text(_text = "Placeholder")
{
	text = _text;
	
	calculate_text_parts();
	
	cursor_max = array_length(text_parts) - 1;
}

function calculate_text_parts()
{
	draw_set_valign(fa_top);
	draw_set_halign(fa_left);
	draw_set_color(c_black);
	draw_set_font(font);
	
	text_parts = [""];
	
	var _text_paragraphs = string_split(text, "\n", true);
	
	var _part_index = 0;
	
	for (var _i = 0; _i < array_length(_text_paragraphs); _i++)
	{
		var _text_paragraph = _text_paragraphs[_i];
		
		var _candidate = text_parts[_part_index] + (string_length(text_parts[_part_index]) == 0 ? "" : "\n\n") +  _text_paragraph;
		
		if (string_height_ext(_candidate, line_separation, line_width) <= height_max)
		{
			text_parts[_part_index] = _candidate;
		}
		else 
		{
			_part_index++;
			
			array_push(text_parts, _text_paragraph);
		}
	}

}

function get_number_of_pages()
{
	return array_length(text_parts);
}

function get_current_page()
{
	return cursor + 1;
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
	draw_set_color(c_white);
	
	var _yy = get_sprite_center_y();
	
	draw_text(x + 15, _yy, locked ? "???" : label);
	
	if (is_new)
	{
		draw_sprite_ext(spr_catalog_new_item, 0, bbox_right - 10, _yy, 0.35, 0.35, 0, c_white, 1);
	}
	
	// image
	if (image_index == 1) return; // not active
	
	var _image = locked ? spr_catalog_question_mark : image;
	var _xx = bbox_right + 30;
	var _yy = top_y + 44;
	
	draw_sprite(_image, 0, _xx, _yy);
	
	// image frame
	var _sprite_width = sprite_get_width(_image);
	var _sprite_height = sprite_get_height(_image);
	var _xx_1 = _xx + _sprite_width;
	var _yy_1 = _yy + _sprite_height;
	
	draw_set_color(frame_color);
	
	draw_rectangle(_xx, _yy, _xx_1, _yy_1, true);
	draw_rectangle(_xx-1, _yy-1, _xx_1+1, _yy_1+1, true);
	
	// description
	_xx = bbox_right + sprite_get_width(image) + 60;
	
	draw_set_valign(fa_top);
	draw_set_halign(fa_left);
	draw_set_color(c_black);
	draw_set_font(font);
	
	if (locked)
	{
		draw_text_ext(_xx, _yy - 2, "Entrada bloqueada.\n\nEncontre o registro para desbloquear.", line_separation, line_width);
	}
	else 
	{
		draw_description(_xx, _yy - 2);
	}
}

function draw_description(_xx, _yy)
{
	draw_set_font(font);
	
	draw_text_ext(_xx, _yy, text_parts[cursor], line_separation, line_width);
}
