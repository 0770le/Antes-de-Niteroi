/// @descr

label				= "Hello, world!";
is_selected			= false;
selection_alpha		= 0.3;
//should_draw		= true;
//is_group			= false;
font = fnt_bookman;
color = c_black;//text

halign = fa_left;
valign = fa_top;

function draw(){
	
	draw_self();

	draw_set_halign(halign);
	draw_set_valign(valign);

	draw_set_color(color);
	draw_set_font(font);
	draw_text(x + 7, y + 5, label);
	
	
	if (is_selected)
	{
		draw_set_alpha(selection_alpha);
	
		draw_rectangle(bbox_left, bbox_top, bbox_right, bbox_bottom, false);
	
		draw_set_alpha(1);
	}
}

function on_click(){
	
}

function set_selected( _is_selected = true) {
	is_selected = _is_selected;
}
