/// @descr

// Inherit the parent event
event_inherited();

//size of this window
window_xscale   = 6;
window_yscale   = 3.5;
// question
statement		= noone;
//buttns nav
option_yes		= noone;
option_no		= noone;

//change question
function set_statement(_statement = "Hello, world?")
{
	statement.label = _statement;
}
//case yes
function on_confirm()
{
	show_debug_message("Confirmed!");
}
//case no
function on_cancel()
{
	show_debug_message("Canceled!");
}
//navigate through buttons

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
		
		on_confirm();
	};
	
	//button no
	option_no = instance_create_layer(statement.x + 25, statement.y + 75, buttons_layer, o_button_option);
	option_no.label = "Não";
	option_no.on_click = function ()
	{
		close();
		
		on_cancel();
	};
	
	array_push(option_group, option_yes, option_no);
	
	update_selected_button(option_yes);
}

init();
