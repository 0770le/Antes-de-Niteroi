/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

buttons = [];
selected_button = noone;

function set_selected_button(_selected_button = noone){
	unselect_all_buttons();
	selected_button = _selected_button;
	selected_button.set_selected(true);
}

function unselect_all_buttons(){
	for (var i = 0; i < array_length(buttons); ++i) {
	    buttons[i].set_selected(false);
	}
}

function add_button(_button){
	array_push(buttons, _button);
	if array_length(buttons) == 1{
		set_selected_button(_button);
	}
}

//navegando no grupo de botoes
function get_next_button(){
	//retorna o index do selecionado
	var _selected_index = array_find_index(buttons, function (_button) { return _button == selected_button; });
	//se acabou ele retorna ele mesmo. se nao ele retorna o prox
	return _selected_index < array_length(buttons) - 1 ? buttons[_selected_index + 1] : selected_button;
}

function get_previous_button()// msma coisa na direçao oposta(subindo)
{
	var _selected_index = array_find_index(buttons, function (_button) { return _button == selected_button; });
	
	return _selected_index > 0 ? buttons[_selected_index - 1] : selected_button;
}