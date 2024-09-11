/// @descr
	
parent_layer	= LAYER_GUI_CONFIRMATION;
buttons_layer	= LAYER_GUI_CONFIRMATION_BUTTONS;
window_layer	= LAYER_GUI_CONFIRMATION_WINDOW;

all_layers		= [];

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
is_open			= false;
option_group    = [];
selected_button = noone;



function open() {
	array_foreach(all_layers, function (_layer) { instance_activate_layer(_layer); });
	
	is_open = true;
}

function close() {
	array_foreach(all_layers, function (_layer) { instance_deactivate_layer(_layer); });
	
	is_open = false;	
	
	set_focus(false);

	on_close();
}

//abstrata
function on_close(){
	
}

function set_title(_title = "Título") {
	title.label = _title;
}
// tira o foco das demais janelas e o coloca na janela que chamou o metodo
function set_focus(_is_focused = false) {
	with (o_abstract_window_controller) {
		is_focused = false;
	}
	
	is_focused = _is_focused;
}

function update_selected_button(_button = instance_create_layer(50, 50, "Instances", o_button_option)) {
	if (selected_button != noone) selected_button.set_selected(false);
	
	selected_button = _button;
	
	selected_button.set_selected(true);
}

function move_up() {
	var _index = array_find_index(option_group, function (_button) { return _button == selected_button; });
	
	if (_index > 0) update_selected_button(option_group[_index - 1]);
}

function move_down() {
	var _index = array_find_index(option_group, function (_button) { return _button == selected_button; });
	
	if (_index < array_length(option_group) - 1) update_selected_button(option_group[_index + 1]);
}

function process_inputs()
{
	get_input();
	
	if is_focused {
		if keyboard_check_pressed(ord("E")) or keyboard_check_pressed(vk_space) {
			selected_button.on_click();
		}
	
		if keyboard_check_pressed(vk_up) or keyboard_check_pressed(ord("W")) {
			move_up();
			
		} else if keyboard_check_pressed(vk_down) or keyboard_check_pressed(ord("S")) {
			move_down();
		}
		
		//if keyboard_check_pressed(ord("Q")) or keyboard_check_pressed(ord("F")) {
		//	selected_button.on_click();
		//}
		
		if keyboard_check_pressed(ord("C")) {
			
			close();
		}
	}
}

//caracteristicas da janela
function create_window() {
	window = instance_create_layer(window_x, window_y, window_layer, o_window_middle_center);
	window.image_xscale = window_xscale;
	window.image_yscale = window_yscale;
	
	title = instance_create_layer(window.bbox_left + 25, window.bbox_top + 25, buttons_layer, o_txt);
	title.label = "Menu";
	title.font = fnt_arial_medium_to_large;
	
	button_cancel = instance_create_layer(window.bbox_right - 25, window.bbox_bottom - 20, buttons_layer, o_txt);
	button_cancel.label = "< C > Voltar";
	button_cancel.halign = fa_right;
	button_cancel.valign = fa_bottom;
	
	button_confirm = instance_create_layer(window.bbox_right - 125, window.bbox_bottom - 20, buttons_layer, o_txt);
	button_confirm.label = "< Espaço > Confirmar";
	button_confirm.halign = fa_right;
	button_confirm.valign = fa_bottom;
}

//abstrato 
function create_content() {
	
}

//abre e fecha a tela
function init_layers() {
	array_push(all_layers, parent_layer, buttons_layer, window_layer);	
}


//metodo padrao pra criaçao inicial da janela
function init() {
	init_layers();
	
	create_window();
	
	create_content();
	
	//
	//fade_to_room();
	
	close();
}

