enum INPUT_TYPE 
{
	IN_GAME, MENU, KEY_MAP
}

enum INPUT_SOURCE_TYPE
{
	GAMEPAD, KEYBOARD
}

enum INPUT_MENU_ACTION 
{
	CONFIRM, CANCEL, TOGGLE_MENU, PAGE_UP, PAGE_DOWN, TAB_LEFT, TAB_RIGHT
}

enum INPUT_IN_GAME_ACTION
{
	JUMP, ATTACK, DODGE, BOW_SHOT, INTERACT
}

gamepad_keymap = // INPUT_IN_GAME_ACTION
[
	gp_face1,
	gp_face2,
	gp_face3,
	gp_face4,
	gp_shoulderr
]

gamepad_button_sprites = // GM Gamepad Input https://manual.gamemaker.io/monthly/en/#t=GameMaker_Language%2FGML_Reference%2FGame_Input%2FGamePad_Input%2FGamepad_Input.htm
[
	spr_gamepad_xbox_a, // gp_face1
	spr_gamepad_xbox_b, // gp_face2
	spr_gamepad_xbox_x, // gp_face3
	spr_gamepad_xbox_y, // gp_face4
	spr_gamepad_xbox_l, // gp_shoulderl
	spr_gamepad_xbox_r, // gp_shoulderr
	spr_gamepad_xbox_lt,// gp_shoulderlb
	spr_gamepad_xbox_rt,// gp_shoulderrb
]

input_in_game_action_names = // INPUT_IN_GAME_ACTION
[
	"Pular", "Atacar", "Esquivar", "Tiro de Arco", "Interagir"
]

input_menu_action_sprites = 
[
	INPUT_SOURCE_TYPE.GAMEPAD,
	INPUT_SOURCE_TYPE.KEYBOARD
]

input_menu_action_sprites[INPUT_SOURCE_TYPE.GAMEPAD] = 
[
	spr_gamepad_xbox_a,     // INPUT_MENU_ACTION.CONFIRM
	spr_gamepad_xbox_b,     // INPUT_MENU_ACTION.CANCEL
	spr_gamepad_xbox_start, // INPUT_MENU_ACTION.TOGGLE_MENU,
	spr_gamepad_xbox_dleft,	// INPUT_MENU_ACTION.PAGE_UP,
	spr_gamepad_xbox_dright,// INPUT_MENU_ACTION.PAGE_DOWN,
	spr_gamepad_xbox_l,		// INPUT_MENU_ACTION.TAB_LEFT,
	spr_gamepad_xbox_r,		// INPUT_MENU_ACTION.TAB_RIGHT,
]

input_menu_action_sprites[INPUT_SOURCE_TYPE.KEYBOARD] = 
[
	spr_keyboard_space,		// INPUT_MENU_ACTION.CONFIRM
	spr_keyboard_c,			// INPUT_MENU_ACTION.CANCEL
	spr_keyboard_escape,  	// INPUT_MENU_ACTION.TOGGLE_MENU
	spr_keyboard_left,		// INPUT_MENU_ACTION.PAGE_UP,
	spr_keyboard_right,		// INPUT_MENU_ACTION.PAGE_DOWN,
	spr_keyboard_page_up,	// INPUT_MENU_ACTION.TAB_LET,
	spr_keyboard_page_down,	// INPUT_MENU_ACTION.TAB_RIGHT,
]

data_sets = 
[
	new InputDataSet(INPUT_TYPE.IN_GAME, new InGameInputModel()),
	new InputDataSet(INPUT_TYPE.MENU, new MenuInputModel()),
	new InputDataSet(INPUT_TYPE.KEY_MAP, new KeyMapInputModel()),
]

last_input_source_type	= INPUT_SOURCE_TYPE.GAMEPAD;
axis_deadzone			= 0.5;

is_capturing			= false;

function start_capture(_menu_item = new MenuInput(INPUT_IN_GAME_ACTION.JUMP))
{
	is_capturing = true;
	
	data_sets[INPUT_TYPE.KEY_MAP].menu_item = _menu_item;
}

function stop_capture()
{
	is_capturing = false;
}

function get_menu_action_sprite(_input_menu_action = INPUT_MENU_ACTION.CONFIRM)
{
	return input_menu_action_sprites[last_input_source_type][_input_menu_action];
}

function get_input_in_game_action_name(_input_in_game_action = INPUT_IN_GAME_ACTION.JUMP)
{
	return input_in_game_action_names[_input_in_game_action];
}

function get_input_in_game_action_sprite(_input_in_game_action = INPUT_IN_GAME_ACTION.JUMP)
{
	return gamepad_button_sprites[gamepad_keymap[_input_in_game_action] - gp_face1];
}

function set_gamepad_key_for_action(_input_in_game_action = INPUT_IN_GAME_ACTION.JUMP, _gm_gamepad_input = gp_face1)
{
	gamepad_keymap[_input_in_game_action] = _gm_gamepad_input;
}

function step()
{
	if (!is_capturing)
	{
		step_not_capturing();
	}
	else
	{
		step_capturing();
	}
}

function step_capturing()
{
	var _checked_key = gamepad_get_checked_key();
	
	if (_checked_key)
	{
		data_sets[INPUT_TYPE.KEY_MAP].input.key_pressed = _checked_key;
		
		notify(INPUT_TYPE.KEY_MAP);
		
		stop_capture();
	}
}

function step_not_capturing()
{
	var _input_menu				= data_sets[INPUT_TYPE.MENU].input;
	var _input_in_game			= data_sets[INPUT_TYPE.IN_GAME].input;
	
	// menu 
	_input_menu.confirm			= keyboard_check_pressed(vk_space) || keyboard_check_pressed(vk_enter) || gamepad_button_check_pressed(0, gp_face1) > 0; // A
	_input_menu.cancel			= keyboard_check_pressed(ord("C")) || gamepad_button_check_pressed(0, gp_face2) > 0; // B
	
	_input_menu.up				= keyboard_check_pressed(vk_up) || gamepad_button_check_pressed(0, gp_padu) > 0 || (gamepad_axis_value(0, gp_axislv) < -axis_deadzone && !_input_in_game.up);  // D-UP
	_input_menu.down			= keyboard_check_pressed(vk_down) || gamepad_button_check_pressed(0, gp_padd) > 0 || (gamepad_axis_value(0, gp_axislv) > axis_deadzone && !_input_in_game.down);  // D-DOWN
	_input_menu.left			= keyboard_check_pressed(vk_left) || gamepad_button_check_pressed(0, gp_padl) > 0 || (gamepad_axis_value(0, gp_axislh) < -axis_deadzone && !_input_in_game.left);  // D-LEFT
	_input_menu.right			= keyboard_check_pressed(vk_right) || gamepad_button_check_pressed(0, gp_padr) > 0 || (gamepad_axis_value(0, gp_axislh) > axis_deadzone && !_input_in_game.right);  // D-DOWN
	
	_input_menu.toggle_menu		= keyboard_check_pressed(vk_f10) || keyboard_check_pressed(vk_escape) || gamepad_button_check_pressed(0, gp_start) > 0;	// START
	_input_menu.toggle_catalog	= keyboard_check_pressed(vk_f9) || gamepad_button_check_pressed(0, gp_select) > 0;	// SELECT
	
	_input_menu.page_up			= keyboard_check_pressed(vk_left) || gamepad_button_check_pressed(0, gp_padl) > 0;	// D-left
	_input_menu.page_down 		= keyboard_check_pressed(vk_right) || gamepad_button_check_pressed(0, gp_padr) > 0;	// D-right
	
	_input_menu.tab_left		= keyboard_check_pressed(vk_pageup) ||  gamepad_button_check_pressed(0, gp_shoulderl) > 0;  // LB
	_input_menu.tab_right 		= keyboard_check_pressed(vk_pagedown) || gamepad_button_check_pressed(0, gp_shoulderr) > 0;	// RB
	
	_input_menu.debug_unlock	= keyboard_check_pressed(ord("O"));
	_input_menu.debug_clear 	= keyboard_check_pressed(ord("P"));
	
	// in game
	_input_in_game.up			= gamepad_button_check(0, gp_padu) > 0 || gamepad_axis_value(0, gp_axislv) < -axis_deadzone; // D-UP
	_input_in_game.down			= gamepad_button_check(0, gp_padd) > 0 || gamepad_axis_value(0, gp_axislv) > axis_deadzone;	 // D-DOWN
	_input_in_game.left			= gamepad_button_check(0, gp_padl) > 0 || gamepad_axis_value(0, gp_axislh) < -axis_deadzone; // D-LEFT
	_input_in_game.right		= gamepad_button_check(0, gp_padr) > 0 || gamepad_axis_value(0, gp_axislh) > axis_deadzone;  // D-DOWN
	
	_input_in_game.attack       = gamepad_button_check_pressed(0, gp_face3) > 0; // X
	_input_in_game.jump			= gamepad_button_check_pressed(0, gp_face1) > 0; // A
	
	var _has_input = false;
	
	// notify
	if (_input_menu.any()) 
	{
		data_sets[INPUT_TYPE.MENU].notify();
		
		_has_input = true;
	}
	
	if (_input_in_game.any()) 
	{
		data_sets[INPUT_TYPE.IN_GAME].notify()
		
		_has_input = true;
	}
	
	update_input_source(_has_input);
}

function update_input_source(_has_input = false)
{
	if (_has_input)
	{
		if (keyboard_check(vk_anykey))
		{
			last_input_source_type = INPUT_SOURCE_TYPE.KEYBOARD;
		}
		else if (gamepad_check_any())
		{
			last_input_source_type = INPUT_SOURCE_TYPE.GAMEPAD;
		}
	}
}

function gamepad_get_checked_key()
{
	for (var _i = gp_face1; _i <= gp_shoulderrb; _i++)
	{
		if (gamepad_button_check_pressed(0, _i))
		{
			return _i;
		}
	}
	
	return false;
}

function gamepad_check_any()
{
	for (var _i = gp_face1; _i < gp_extra6; _i++)
	{
	    if (gamepad_button_check(0, _i)) {
	        
			return true;			
        }
    }
	
	if (gamepad_axis_value(0, gp_axisrv) < -axis_deadzone || gamepad_axis_value(0, gp_axisrv) > axis_deadzone
		|| gamepad_axis_value(0, gp_axislv) < -axis_deadzone || gamepad_axis_value(0, gp_axislv) > axis_deadzone)
	{
		return true;
	}
	
	return false;
}

function get_input_sprite_scale()
{
	return last_input_source_type == INPUT_SOURCE_TYPE.GAMEPAD ? 2 : 1.8;
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