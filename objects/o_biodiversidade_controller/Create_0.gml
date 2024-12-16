/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

// Inherit the parent event
event_inherited();

parent_layer				= LAYER_GUI_BIODIVERSIDADE;
window_layer				= LAYER_GUI_BIODIVERSIDADE_WINDOW;
buttons_layer				= LAYER_GUI_BIODIVERSIDADE_BUTTONS;

window_xscale				= 6.5;
window_yscale				= 3.2;

buttons_by_type = ds_map_create();



function create_content() {
	title.label = "Registros";

	var _log_types= o_log_registry.get_log_types();
	
	for (var i = 0; i < array_length(_log_types); ++i) {
	    var _type = _log_types[i];
		
		var _log = o_log_registry.get_log_by_type(_type);
		
		var _aux = {
			log:_log, 
			callback: function() {
					o_log_disclosure.set_log(self.log);	
			}
		}
		
		
		//adiciona botoes
		var _button = instance_create_layer(title.x + 25, title.y + 50 +(i*25), buttons_layer, o_button_option);
		//cor do texto
		_button.label = _log.name;
		//funçao
		_button.on_click = _aux.callback
		
		array_push(option_group,_button);
	}
	
	
	
	update_selected_button(option_group[0]);

	

}

init();