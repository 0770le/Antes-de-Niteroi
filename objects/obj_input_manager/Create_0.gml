enum INPUT_TYPE 
{
	IN_GAME, MENU
}

data_sets = 
[
	new InputDataSet(INPUT_TYPE.IN_GAME, new InGameInputModel()),
	new InputDataSet(INPUT_TYPE.MENU, new MenuInputModel())
]

axis_deadzone = 0.5;

function step()
{
	var _input_menu = data_sets[INPUT_TYPE.MENU].input;
	var _input_in_game = data_sets[INPUT_TYPE.IN_GAME].input;
	
	// menu 
	_input_menu.confirm		= keyboard_check_pressed(vk_space) || gamepad_button_check_pressed(0, gp_face1) > 0; // A
	_input_menu.cancel      = keyboard_check_pressed(vk_escape) || gamepad_button_check_pressed(0, gp_face2) > 0; // B
	
	_input_menu.up			= keyboard_check_pressed(vk_up) || gamepad_button_check_pressed(0, gp_padu) > 0 || (gamepad_axis_value(0, gp_axislv) < -axis_deadzone && !_input_in_game.up);  // D-UP
	_input_menu.down		= keyboard_check_pressed(vk_down) || gamepad_button_check_pressed(0, gp_padd) > 0 || (gamepad_axis_value(0, gp_axislv) > axis_deadzone && !_input_in_game.down);  // D-DOWN
	_input_menu.left		= keyboard_check_pressed(vk_left) || gamepad_button_check_pressed(0, gp_padl) > 0 || (gamepad_axis_value(0, gp_axislh) < -axis_deadzone && !_input_in_game.left);  // D-LEFT
	_input_menu.right		= keyboard_check_pressed(vk_right) || gamepad_button_check_pressed(0, gp_padr) > 0 || (gamepad_axis_value(0, gp_axislh) > axis_deadzone && !_input_in_game.right);  // D-DOWN
	
	_input_menu.toggle_menu    = keyboard_check_pressed(vk_f10) || keyboard_check_pressed(vk_escape) || gamepad_button_check_pressed(0, gp_start) > 0;	// START
	_input_menu.toggle_catalog = keyboard_check_pressed(vk_f9) || gamepad_button_check_pressed(0, gp_select) > 0;	// SELECT
	
	// in game
	_input_in_game.up			= gamepad_button_check(0, gp_padu) > 0 || gamepad_axis_value(0, gp_axislv) < -axis_deadzone; // D-UP
	_input_in_game.down			= gamepad_button_check(0, gp_padd) > 0 || gamepad_axis_value(0, gp_axislv) > axis_deadzone;	 // D-DOWN
	_input_in_game.left			= gamepad_button_check(0, gp_padl) > 0 || gamepad_axis_value(0, gp_axislh) < -axis_deadzone; // D-LEFT
	_input_in_game.right			= gamepad_button_check(0, gp_padr) > 0 || gamepad_axis_value(0, gp_axislh) > axis_deadzone;  // D-DOWN
	
	_input_in_game.attack        = gamepad_button_check_pressed(0, gp_face3) > 0; // X
	_input_in_game.jump			= gamepad_button_check_pressed(0, gp_face1) > 0; // A
	
	// notify
	if (_input_menu.any()) data_sets[INPUT_TYPE.MENU].notify();
	if (_input_in_game.any()) data_sets[INPUT_TYPE.IN_GAME].notify();
}

#region events
function subscribe(_object = noone, _input_type = INPUT_TYPE.MENU) 
{
	data_sets[_input_type].subscribe(_object);
}

function unsubscribe(_object = noone, _input_type = INPUT_TYPE.MENU)
{
	data_sets[_input_type].unsubscribe(_object);
}

function notify(_input_type = INPUT_TYPE.MENU)
{
	data_sets[_input_type].notify();
}
#endregion

function init() 
{
	global.input_manager = self;
}

init();