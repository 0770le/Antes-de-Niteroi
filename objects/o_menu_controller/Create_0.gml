event_inherited();

enum MENU_BUTTON {
CLOSE,		//0
LOG,		//1
QUIT		//2
}

parent_layer		= LAYER_GUI_MENU;
window_layer		= LAYER_GUI_MENU_WINDOW;
buttons_layer		= LAYER_GUI_MENU_BUTTONS;

window_xscale		= 6.5;
window_yscale		= 3.2;

button_close		= noone;
button_quit			= noone;
button_log			= noone;

//recebe a funçao do parent e guarda
parent_open			= open;
parent_close		= close;

function open() {
	//pause game
	instance_deactivate_all(true);
	instance_activate_layer(LAYER_CONTROLLERS);
	
	parent_open();
	
	set_focus(true);
}


//despausa o jogo, fecha outras janelas, chama parent close e tira o foco de outras janelas
function close() {
	instance_activate_all();
	
	o_confirmation_controller.close();
	o_log_controller.close();
	
	parent_close();
	
	set_focus(false);
}

function create_content() {
	title.label = "Menu";
	
	//adiciona botoes
	button_close = instance_create_layer(title.x + 25, title.y + 50, buttons_layer, o_button_option);
	//cor do texto
	button_close.label = "Voltar ao jogo"
	//funçao
	button_close.on_click = function() {
		close()
	};
	update_selected_button(button_close);

	button_log = instance_create_layer(title.x + 25, title.y + 75, buttons_layer, o_button_option);
	button_log.label = "Log"
	//funçao de chamar o log
	button_log.on_click = function() {
		o_log_controller.open();
		o_log_controller.set_focus(true);
		o_log_controller.on_close = function() {
			//dealy para evitar que a funçao ocorra no mesmo frame
			call_later(1, time_source_units_frames, function () { set_focus(true) });
		};
	};

	button_quit = instance_create_layer(title.x + 25, title.y + 100, buttons_layer, o_button_option);
	button_quit.label = "Sair do jogo"
	
	button_quit.on_click = function() {
		//sobrescrevi a funçao on_confirm para fechar o jogo
		o_confirmation_controller.on_confirm = function() {
			game_end();
		}
		
		o_confirmation_controller.on_cancel = function() {
			//dealy para evitar que a funçao ocorra no mesmo frame "reabrir confirmaçao"
			call_later(1, time_source_units_frames, function () { set_focus(true) });
		}
		//mudança da pergunta
		o_confirmation_controller.set_statement("Deseja sair do jogo?")
		o_confirmation_controller.set_focus(true);
		o_confirmation_controller.open();		
	};
	
	array_push(option_group, button_close, button_log, button_quit);
}

init();