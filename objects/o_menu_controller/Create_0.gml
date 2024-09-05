enum MENU_BUTTON {
CLOSE,		//0
QUIT		//1

}

parent_layer		= LAYER_GUI_MENU;
window_layer		= LAYER_GUI_MENU_WINDOW;
buttons_layer		= LAYER_GUI_MENU_BUTTONS;
sub_layers			= get_sub_layers(parent_layer);

window = noone;
is_open = false;
is_focused = false;

title = noone;
button_close = noone;
selected_button = noone;
button_quit = noone;


//groups
main_group = noone;
selected_group = noone;

function set_focused(_is_focused) {
	is_focused = _is_focused;
}

function set_selected_button(_selected_button = noone){
	unselect_all_buttons();
	selected_button = _selected_button;
	selected_button.set_selected(true);
}

function unselect_all_buttons(){
	button_close.set_selected(false);
}

//pause game
function open() {
	instance_deactivate_all(true);
	array_foreach(sub_layers, function(_layer) { instance_activate_layer(_layer); });
	is_open = true;

}

function close() {
	instance_activate_all();
	array_foreach(sub_layers, function(_layer) { instance_deactivate_layer(_layer); });
	is_open = false;
	
}

function create_window() {
	window = instance_create_layer(window_get_width()/4, window_get_height()/4, window_layer, o_window_middle_center);

	//acertar numeros manualmente
	window.image_xscale = 4.5;
	window.image_yscale = 3;
	
	title = instance_create_layer(window.bbox_left + 10, window.bbox_top +10, buttons_layer, o_txt);
	title.label = "MENU";
	
	button_close = instance_create_layer(title.x +5, title.y + 30, buttons_layer, o_button);
	//cor do texto
	button_close.color = c_black;
	button_close.label = "Voltar ao jogo"
	button_close.on_click = function(){close()};
	set_selected_button(button_close);


	button_quit = instance_create_layer(button_close.x, button_close.bbox_bottom, buttons_layer, o_button);
	button_quit.color = c_black;
	button_quit.label = "Sair do jogo"
	//button_quit.on_click = function(){
	//	o_confirmation_controller.on_confirm = function(){
	//		game_end();
	//	}
		
	//	o_confirmation_controller.on_cancel = function() {
	//		o_confirmation_controller.close();
	//		o_confirmation_controller.set_focus(false);
	//		set_focused(true);
	//	}
		
	//	o_confirmation_controller.open();
	//	o_confirmation_controller.set_focus(true);
		
	//};

	//group
		//nao aparece
	main_group = instance_create_layer(0,0, window_layer, o_button_group);
	main_group.add_button(button_close); //seleciona o primeiro por padrao
	main_group.add_button(button_quit); //seleciona o primeiro por padrao
	selected_group = main_group;

	
}

function init() {
	create_window();
	close();
}


init();