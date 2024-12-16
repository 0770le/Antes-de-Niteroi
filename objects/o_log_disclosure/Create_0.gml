/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

// Inherit the parent event
event_inherited();

parent_layer				= LAYER_GUI_LOG_ENTRY;
window_layer				= LAYER_GUI_LOG_ENTRY_WINDOW;
buttons_layer				= LAYER_GUI_LOG_ENTRY_BUTTONS;

window_xscale				= 6.5;
window_yscale				= 3.2;


log = new LogArara();

function set_log(_log = new LogArara()) {
	log = _log;
}

parent_init = init;
function init(){
	parent_init();
	close();
	
}


init();