/// @descr
	
parent_layer	= LAYER_GUI_CONFIRMATION;
buttons_layer	= LAYER_GUI_CONFIRMATION_BUTTONS;
window_layer	= LAYER_GUI_CONFIRMATION_WINDOW;

all_layers = [];

//local em que aparece (centro)
window_x		= window_get_width() / 4;
window_y		= window_get_height() / 4;

//tamanho do sprite (64x64)
window_xscale   = 6;
window_yscale   = 4;

is_focused		= false;

// specifics

window			= noone;
title			= noone;
button_confirm	= noone;
button_cancel	= noone;
is_open			= false;

function open() {
	array_foreach(all_layers, function (_layer) { instance_activate_layer(_layer); });
	
	is_open = true;
	
}

function close() {
	array_foreach(all_layers, function (_layer) { instance_deactivate_layer(_layer); });
	
	is_open = false;
	
}

function set_focus(_is_focused = false) {
	is_focused = _is_focused;
}

function create_window()
{
	window = instance_create_layer(window_x, window_y, window_layer, o_window_middle_center);
	window.image_xscale = window_xscale;
	window.image_yscale = window_yscale;
	
	title = instance_create_layer(window.bbox_left + 25, window.bbox_top + 25, buttons_layer, o_txt);
	title.label = "Menu";
	title.font = fnt_arial_medium_to_large;
	
	button_cancel = instance_create_layer(window.bbox_right - 25, window.bbox_bottom - 20, buttons_layer, o_txt);
	button_cancel.label = "< Esc > Cancelar";
	button_cancel.halign = fa_right;
	button_cancel.valign = fa_bottom;
	
	button_confirm = instance_create_layer(window.bbox_right - 175, window.bbox_bottom - 20, buttons_layer, o_txt);
	button_confirm.label = "< Enter > Confirmar";
	button_confirm.halign = fa_right;
	button_confirm.valign = fa_bottom;
}

function create_content(){
	
}

function init_layers() {
	all_layers = get_sub_layers(parent_layer);
	//array_push(all_layers, parent_layer, buttons_layer, window_layer);	
}

function init() {
	init_layers();
	create_window();
	create_content();
	close();
}

