/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

// Inherit the parent event
event_inherited();

parent_layer				= LAYER_GUI_LOG;
window_layer				= LAYER_GUI_LOG_WINDOW;
buttons_layer				= LAYER_GUI_LOG_BUTTONS;

window_xscale				= 6.5;
window_yscale				= 3.2;

button_biodiversidade		= noone;
button_regioes				= noone;
button_historia				= noone;

function create_content() {
	title.label = "Registros";
	
	//adiciona botoes
	button_biodiversidade = instance_create_layer(title.x + 25, title.y + 50, buttons_layer, o_button_option);
	//cor do texto
	button_biodiversidade.label = "Biodiversidade"
	//funçao
	button_biodiversidade.on_click = function() {
		o_biodiversidade_controller.open();
		o_biodiversidade_controller.set_focus(true);
	};
	
	button_biodiversidade.on_click = function() {
		call_later(1,time_source_units_frames, function(){
			set_focus(true);
		});
	};
	update_selected_button(button_biodiversidade);

	button_regioes = instance_create_layer(title.x + 25, title.y + 75, buttons_layer, o_button_option);
	button_regioes.label = "Regiões"
	//funçao de chamar o log
	button_regioes.on_click = function() {
		
	};

	button_historia = instance_create_layer(title.x + 25, title.y + 100, buttons_layer, o_button_option);
	button_historia.label = "História"
	
	button_historia.on_click = function() {
		
	};
	
	array_push(option_group, button_biodiversidade, button_regioes, button_historia);
}

init();