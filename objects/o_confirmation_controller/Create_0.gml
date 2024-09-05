/// @descr

// Inherit the parent event
event_inherited();

enum CONFIRMATION
{
	QUIT_GAME
}
//size of this window
window_xscale   = 6;
window_yscale   = 4;
// question
statement		= noone;
//buttns nav
option_group	= [];
option_yes		= noone;
option_no		= noone;

selected_button = noone;

interaction		= CONFIRMATION.QUIT_GAME;

//change question
function set_statement(_statement = "Hello, world?")
{
	statement.label = _statement;
}
//change windonw title
function set_title(_title = "Título")
{
	title.label = _title;
}
//change interaction
function set_interaction(_interaction = CONFIRMATION.QUIT_GAME)
{
	interaction = _interaction;
}
//case yes
function on_confirm(_interaction = CONFIRMATION.QUIT_GAME)
{
	show_debug_message("Confirmed!");
}
//case no
function on_cancel(_interaction = CONFIRMATION.QUIT_GAME)
{
	show_debug_message("Canceled!");
}
//navigate through buttons
function update_selected_button(_button = instance_create_layer(50, 50, "Instances", obj_button))
{
	if (selected_button != noone) selected_button.set_selected(false);
	
	selected_button = _button;
	
	selected_button.set_selected(true);
}

function move_up()
{
	var _index = array_find_index(option_group, function (_button) { return _button == selected_button; });
	
	if (_index > 0) update_selected_button(option_group[_index - 1]);
}

function move_down()
{
	var _index = array_find_index(option_group, function (_button) { return _button == selected_button; });
	
	if (_index < array_length(option_group) - 1) update_selected_button(option_group[_index + 1]);
}


function create_content() {
	//aparece
	title.label = "Confirmação";
	
	
	
	//text question
	statement = instance_create_layer(title.x, window.bbox_top + 75, buttons_layer, o_txt);
	statement.font = fnt_arial_medium;
	statement.label = "Deseja confirmar?";
	
	
	//button yes
	option_yes = instance_create_layer(statement.x + 25, statement.y + 50, buttons_layer, o_button_option);
	option_yes.label = "Sim";
	option_yes.set_selected(true);
	option_yes.on_click = function ()
	{
		close();
		
		on_confirm(interaction);
	};
	
	//button no
	option_no = instance_create_layer(statement.x + 25, statement.y + 75, buttons_layer, o_button_option);
	option_no.label = "Não";
	option_no.on_click = function ()
	{
		close();
		
		on_cancel(interaction);
	};
	
	array_push(option_group, option_yes, option_no);
	
	update_selected_button(option_yes);
}

init();
