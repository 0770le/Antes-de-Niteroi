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
	JUMP, ATTACK, DODGE, BOW_SHOT, INTERACT, UP, LEFT, DOWN, RIGHT
}

enum GAMEPAD_TYPE 
{
	XBOX, PLAYSTATION, SWITCH
}

gamepad_keymap = // INPUT_IN_GAME_ACTION
[
	gp_face1,
	gp_face2,
	gp_face3,
	gp_face4,
	gp_shoulderr
]

keyboard_keymap = 
[
	vk_space,
	ord("J"),
	ord("K"),
	ord("L"),
	ord("U"),
	vk_up,
	vk_left,
	vk_down,
	vk_right,
]

gamepad_button_sprites = // GM Gamepad Input https://manual.gamemaker.io/monthly/en/#t=GameMaker_Language%2FGML_Reference%2FGame_Input%2FGamePad_Input%2FGamepad_Input.htm
[
	[
		spr_gamepad_xbox_a, // gp_face1
		spr_gamepad_xbox_b, // gp_face2
		spr_gamepad_xbox_x, // gp_face3
		spr_gamepad_xbox_y, // gp_face4
		spr_gamepad_xbox_l, // gp_shoulderl
		spr_gamepad_xbox_r, // gp_shoulderr
		spr_gamepad_xbox_lt,// gp_shoulderlb
		spr_gamepad_xbox_rt,// gp_shoulderrb
	],
	[
		spr_gamepad_playstation_x,
		spr_gamepad_playstation_circle,
		spr_gamepad_playstation_square,
		spr_gamepad_playstation_triangle,
		spr_gamepad_playstation_l1,
		spr_gamepad_playstation_r1,
		spr_gamepad_playstation_l2,
		spr_gamepad_playstation_r2,
	],
	[
		spr_gamepad_switch_b,
		spr_gamepad_switch_a,
		spr_gamepad_switch_y,
		spr_gamepad_switch_x,
		spr_gamepad_switch_l,
		spr_gamepad_switch_r,
		spr_gamepad_switch_zl,
		spr_gamepad_switch_zl
	]
]

#region keyboard_button_sprites
keyboard_button_sprites = ds_map_create();
// keyboard_button_sprites[? vk_escape] = spr_keyboard_escape; // mandar para o inferno quem apertar essa tecla
keyboard_button_sprites[? vk_f1] = spr_keyboard_f1;
keyboard_button_sprites[? vk_f2] = spr_keyboard_f2;
keyboard_button_sprites[? vk_f3] = spr_keyboard_f3;
keyboard_button_sprites[? vk_f4] = spr_keyboard_f4;
keyboard_button_sprites[? vk_f5] = spr_keyboard_f5;
keyboard_button_sprites[? vk_f6] = spr_keyboard_f6;
keyboard_button_sprites[? vk_f7] = spr_keyboard_f7;
keyboard_button_sprites[? vk_f8] = spr_keyboard_f8;
keyboard_button_sprites[? vk_f9] = spr_keyboard_f9;
keyboard_button_sprites[? vk_f10] = spr_keyboard_f10;
keyboard_button_sprites[? vk_f11] = spr_keyboard_f11;
keyboard_button_sprites[? vk_f12] = spr_keyboard_f12;
//
keyboard_button_sprites[? ord("`")] = spr_keyboard_grave;
keyboard_button_sprites[? ord("1")] = spr_keyboard_1;
keyboard_button_sprites[? ord("2")] = spr_keyboard_2;
keyboard_button_sprites[? ord("3")] = spr_keyboard_3;
keyboard_button_sprites[? ord("4")] = spr_keyboard_4;
keyboard_button_sprites[? ord("5")] = spr_keyboard_5;
keyboard_button_sprites[? ord("6")] = spr_keyboard_6;
keyboard_button_sprites[? ord("7")] = spr_keyboard_7;
keyboard_button_sprites[? ord("8")] = spr_keyboard_8;
keyboard_button_sprites[? ord("9")] = spr_keyboard_9;
keyboard_button_sprites[? ord("0")] = spr_keyboard_0;
keyboard_button_sprites[? vk_backspace] = spr_keyboard_backspace;
//
keyboard_button_sprites[? vk_tab] = spr_keyboard_tab;
keyboard_button_sprites[? ord("Q")] = spr_keyboard_q;
keyboard_button_sprites[? ord("W")] = spr_keyboard_w;
keyboard_button_sprites[? ord("E")] = spr_keyboard_e;
keyboard_button_sprites[? ord("R")] = spr_keyboard_r;
keyboard_button_sprites[? ord("T")] = spr_keyboard_t;
keyboard_button_sprites[? ord("Y")] = spr_keyboard_y;
keyboard_button_sprites[? ord("U")] = spr_keyboard_u;
keyboard_button_sprites[? ord("I")] = spr_keyboard_i;
keyboard_button_sprites[? ord("O")] = spr_keyboard_o;
keyboard_button_sprites[? ord("P")] = spr_keyboard_p;
keyboard_button_sprites[? ord("[")] = spr_keyboard_left_bracket;
keyboard_button_sprites[? ord("]")] = spr_keyboard_right_bracket;
keyboard_button_sprites[? ord("\\")] = spr_keyboard_back_slash;
//
keyboard_button_sprites[? ord("A")] = spr_keyboard_a;
keyboard_button_sprites[? ord("S")] = spr_keyboard_s;
keyboard_button_sprites[? ord("D")] = spr_keyboard_d;
keyboard_button_sprites[? ord("F")] = spr_keyboard_f;
keyboard_button_sprites[? ord("G")] = spr_keyboard_g;
keyboard_button_sprites[? ord("H")] = spr_keyboard_h;
keyboard_button_sprites[? ord("J")] = spr_keyboard_j;
keyboard_button_sprites[? ord("K")] = spr_keyboard_k;
keyboard_button_sprites[? ord("L")] = spr_keyboard_l;
keyboard_button_sprites[? ord(";")] = spr_keyboard_colon;
keyboard_button_sprites[? ord("'")] = spr_keyboard_quotes;
keyboard_button_sprites[? vk_enter] = spr_keyboard_enter;
// 
keyboard_button_sprites[? vk_shift] = spr_keyboard_shift;
keyboard_button_sprites[? ord("Z")] = spr_keyboard_z;
keyboard_button_sprites[? ord("X")] = spr_keyboard_x;
keyboard_button_sprites[? ord("C")] = spr_keyboard_c;
keyboard_button_sprites[? ord("V")] = spr_keyboard_v;
keyboard_button_sprites[? ord("B")] = spr_keyboard_b;
keyboard_button_sprites[? ord("N")] = spr_keyboard_n;
keyboard_button_sprites[? ord("M")] = spr_keyboard_m;
keyboard_button_sprites[? ord(",")] = spr_keyboard_comma;
keyboard_button_sprites[? ord(".")] = spr_keyboard_dot;
keyboard_button_sprites[? ord("/")] = spr_keyboard_foward_slash;
//
keyboard_button_sprites[? vk_control] = spr_keyboard_ctrl;
keyboard_button_sprites[? vk_alt] = spr_keyboard_alt;
keyboard_button_sprites[? vk_space] = spr_keyboard_space;
// 
keyboard_button_sprites[? vk_insert] = spr_keyboard_insert;
keyboard_button_sprites[? vk_home] = spr_keyboard_home;
keyboard_button_sprites[? vk_pageup] = spr_keyboard_page_up;
keyboard_button_sprites[? vk_delete] = spr_keyboard_delete;
keyboard_button_sprites[? vk_end] = spr_keyboard_end;
keyboard_button_sprites[? vk_pagedown] = spr_keyboard_page_down;
//
keyboard_button_sprites[? vk_up] = spr_keyboard_up;
keyboard_button_sprites[? vk_left] = spr_keyboard_left;
keyboard_button_sprites[? vk_down] = spr_keyboard_down;
keyboard_button_sprites[? vk_right] = spr_keyboard_right;
#endregion

input_in_game_action_names = // INPUT_IN_GAME_ACTION
[
	"Pular", "Atacar", "Esquivar", "Tiro de Arco", "Interagir", "Cima", "Esquerda", "Baixo", "Direita"
]

input_menu_action_sprites = 
[
	INPUT_SOURCE_TYPE.GAMEPAD,
	INPUT_SOURCE_TYPE.KEYBOARD
]

input_menu_action_sprites[INPUT_SOURCE_TYPE.GAMEPAD] = 
[
	[
		spr_gamepad_xbox_a,     // INPUT_MENU_ACTION.CONFIRM
		spr_gamepad_xbox_b,     // INPUT_MENU_ACTION.CANCEL
		spr_gamepad_xbox_start, // INPUT_MENU_ACTION.TOGGLE_MENU,
		spr_gamepad_xbox_dleft,	// INPUT_MENU_ACTION.PAGE_UP,
		spr_gamepad_xbox_dright,// INPUT_MENU_ACTION.PAGE_DOWN,
		spr_gamepad_xbox_l,		// INPUT_MENU_ACTION.TAB_LEFT,
		spr_gamepad_xbox_r,		// INPUT_MENU_ACTION.TAB_RIGHT,
	],
	[
		spr_gamepad_playstation_x,
		spr_gamepad_playstation_circle,
		spr_gamepad_playstation_start,
		spr_gamepad_playstation_dleft,
		spr_gamepad_playstation_dright,
		spr_gamepad_playstation_l1,
		spr_gamepad_playstation_r1,
	],
	[
		spr_gamepad_switch_b,
		spr_gamepad_switch_a,
		spr_gamepad_switch_start,
		spr_gamepad_switch_dleft,
		spr_gamepad_switch_dright,
		spr_gamepad_switch_l,
		spr_gamepad_switch_r,
	]
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
last_gamepad_type		= GAMEPAD_TYPE.XBOX;
last_gamepad_index		= 0;
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
	if (last_input_source_type == INPUT_SOURCE_TYPE.GAMEPAD)
	{
		return input_menu_action_sprites[last_input_source_type][last_gamepad_type][_input_menu_action];
	}
	else 
	{
		return input_menu_action_sprites[last_input_source_type][_input_menu_action];
	}
}

function get_input_in_game_action_name(_input_in_game_action = INPUT_IN_GAME_ACTION.JUMP)
{
	return input_in_game_action_names[_input_in_game_action];
}

function get_input_in_game_action_sprite(_input_in_game_action = INPUT_IN_GAME_ACTION.JUMP, _input_source_type = last_input_source_type)
{
	if (_input_source_type == INPUT_SOURCE_TYPE.GAMEPAD)
	{
		return gamepad_button_sprites[last_gamepad_type][gamepad_keymap[_input_in_game_action] - gp_face1];
	}
	else 
	{
		return keyboard_button_sprites[? keyboard_keymap[_input_in_game_action]];
	}	
}

function set_gamepad_key_for_action(_input_in_game_action = INPUT_IN_GAME_ACTION.JUMP, _gm_gamepad_input = gp_face1)
{
	for (var _i = 0; _i < array_length(gamepad_keymap); _i++)
	{
		if (gamepad_keymap[_i] == _gm_gamepad_input)
		{
			gamepad_keymap[_i] = gamepad_keymap[_input_in_game_action];
			
			break;		
		} 
	}
	
	gamepad_keymap[_input_in_game_action] = _gm_gamepad_input;
	
	global.options_controller.set_option(OPTIONS_GAMEPAD_KEYMAP, gamepad_keymap);
}

function set_keyboard_key_for_action(_input_in_game_action = INPUT_IN_GAME_ACTION.JUMP, _keyboard_input_key = vk_space)
{
	for (var _i = 0; _i < array_length(keyboard_keymap); _i++)
	{
		if (keyboard_keymap[_i] == _keyboard_input_key)
		{
			keyboard_keymap[_i] = keyboard_keymap[_input_in_game_action];
			
			break;		
		} 
	}
	
	keyboard_keymap[_input_in_game_action] = _keyboard_input_key;
	
	global.options_controller.set_option(OPTIONS_KEYBOARD_KEYMAP, keyboard_keymap);
}

function step()
{
	if (is_capturing)
	{
		step_capturing();
	}
	else
	{
		step_not_capturing();
	}
}

function step_capturing()
{
	data_sets[INPUT_TYPE.KEY_MAP].input.cancel = gamepad_button_check_pressed(last_gamepad_index, gp_start) || keyboard_check_pressed(vk_escape);
	
	if (data_sets[INPUT_TYPE.KEY_MAP].input.cancel)
	{
		notify(INPUT_TYPE.KEY_MAP);
		
		stop_capture();
	}
	else 
	{
		var _checked_key = false;
		
		if (data_sets[INPUT_TYPE.KEY_MAP].menu_item.input_source_type == INPUT_SOURCE_TYPE.GAMEPAD)
		{
			_checked_key = gamepad_get_checked_key();
		}
		else 
		{
			_checked_key = keyboard_get_checked_key();
		}
		
		if (_checked_key)
		{
			data_sets[INPUT_TYPE.KEY_MAP].input.key_pressed = _checked_key;
		
			notify(INPUT_TYPE.KEY_MAP);
		
			stop_capture();
		}
		
	}
	
	// update input icons
	step_not_capturing(false);
}

function step_not_capturing(_should_notify = true)
{
	update_input_source();
	
	var _input_menu				= data_sets[INPUT_TYPE.MENU].input;
	var _input_in_game			= data_sets[INPUT_TYPE.IN_GAME].input;
	
	// menu 
	_input_menu.confirm			= keyboard_check_pressed(vk_space) || keyboard_check_pressed(vk_enter) || gamepad_button_check_pressed(last_gamepad_index, gp_face1) > 0; // A
	_input_menu.cancel			= keyboard_check_pressed(ord("C")) || gamepad_button_check_pressed(last_gamepad_index, gp_face2) > 0; // B
	
	_input_menu.up				= keyboard_check_pressed(vk_up) || gamepad_button_check_pressed(last_gamepad_index, gp_padu) > 0 || (gamepad_axis_value(last_gamepad_index, gp_axislv) < -axis_deadzone && !_input_in_game.up);  // D-UP
	_input_menu.down			= keyboard_check_pressed(vk_down) || gamepad_button_check_pressed(last_gamepad_index, gp_padd) > 0 || (gamepad_axis_value(last_gamepad_index, gp_axislv) > axis_deadzone && !_input_in_game.down);  // D-DOWN
	_input_menu.left			= keyboard_check_pressed(vk_left) || gamepad_button_check_pressed(last_gamepad_index, gp_padl) > 0 || (gamepad_axis_value(last_gamepad_index, gp_axislh) < -axis_deadzone && !_input_in_game.left);  // D-LEFT
	_input_menu.right			= keyboard_check_pressed(vk_right) || gamepad_button_check_pressed(last_gamepad_index, gp_padr) > 0 || (gamepad_axis_value(last_gamepad_index, gp_axislh) > axis_deadzone && !_input_in_game.right);  // D-DOWN
	
	_input_menu.toggle_menu		= keyboard_check_pressed(vk_f10) || keyboard_check_pressed(vk_escape) || gamepad_button_check_pressed(last_gamepad_index, gp_start) > 0;	// START
	_input_menu.toggle_catalog	= keyboard_check_pressed(vk_f9) || gamepad_button_check_pressed(last_gamepad_index, gp_select) > 0;	// SELECT
	
	_input_menu.page_up			= keyboard_check_pressed(vk_left) || gamepad_button_check_pressed(last_gamepad_index, gp_padl) > 0;	// D-left
	_input_menu.page_down 		= keyboard_check_pressed(vk_right) || gamepad_button_check_pressed(last_gamepad_index, gp_padr) > 0;	// D-right
	
	_input_menu.tab_left		= keyboard_check_pressed(vk_pageup) ||  gamepad_button_check_pressed(last_gamepad_index, gp_shoulderl) > 0;  // LB
	_input_menu.tab_right 		= keyboard_check_pressed(vk_pagedown) || gamepad_button_check_pressed(last_gamepad_index, gp_shoulderr) > 0;	// RB
	
	_input_menu.debug_unlock	= keyboard_check_pressed(ord("O"));
	_input_menu.debug_clear 	= keyboard_check_pressed(ord("P"));
	
	// in game
	_input_in_game.up			= gamepad_button_check(last_gamepad_index, gp_padu) > 0 || gamepad_axis_value(last_gamepad_index, gp_axislv) < -axis_deadzone	|| keyboard_check(keyboard_keymap[INPUT_IN_GAME_ACTION.UP]);
	_input_in_game.down			= gamepad_button_check(last_gamepad_index, gp_padd) > 0 || gamepad_axis_value(last_gamepad_index, gp_axislv) > axis_deadzone	|| keyboard_check(keyboard_keymap[INPUT_IN_GAME_ACTION.DOWN]);
	_input_in_game.left			= gamepad_button_check(last_gamepad_index, gp_padl) > 0 || gamepad_axis_value(last_gamepad_index, gp_axislh) < -axis_deadzone || keyboard_check(keyboard_keymap[INPUT_IN_GAME_ACTION.LEFT]);
	_input_in_game.right		= gamepad_button_check(last_gamepad_index, gp_padr) > 0 || gamepad_axis_value(last_gamepad_index, gp_axislh) > axis_deadzone  || keyboard_check(keyboard_keymap[INPUT_IN_GAME_ACTION.RIGHT]);	
	
	_input_in_game.attack       = gamepad_button_check_pressed(last_gamepad_index, gamepad_keymap[INPUT_IN_GAME_ACTION.ATTACK]) > 0   || keyboard_check_pressed(keyboard_keymap[INPUT_IN_GAME_ACTION.ATTACK]);
	_input_in_game.jump			= gamepad_button_check_pressed(last_gamepad_index, gamepad_keymap[INPUT_IN_GAME_ACTION.JUMP]) > 0	 || keyboard_check_pressed(keyboard_keymap[INPUT_IN_GAME_ACTION.JUMP]);
	_input_in_game.dodge		= gamepad_button_check_pressed(last_gamepad_index, gamepad_keymap[INPUT_IN_GAME_ACTION.DODGE]) > 0	 || keyboard_check_pressed(keyboard_keymap[INPUT_IN_GAME_ACTION.DODGE]);
	_input_in_game.bow_shot		= gamepad_button_check_pressed(last_gamepad_index, gamepad_keymap[INPUT_IN_GAME_ACTION.BOW_SHOT]) > 0 || keyboard_check_pressed(keyboard_keymap[INPUT_IN_GAME_ACTION.BOW_SHOT]);
	_input_in_game.interact		= gamepad_button_check_pressed(last_gamepad_index, gamepad_keymap[INPUT_IN_GAME_ACTION.INTERACT]) > 0 || keyboard_check_pressed(keyboard_keymap[INPUT_IN_GAME_ACTION.INTERACT]);
	
	_input_in_game.attack_held  = gamepad_button_check(last_gamepad_index, gamepad_keymap[INPUT_IN_GAME_ACTION.ATTACK]) > 0			 || keyboard_check(keyboard_keymap[INPUT_IN_GAME_ACTION.ATTACK]);
	_input_in_game.jump_held	= gamepad_button_check(last_gamepad_index, gamepad_keymap[INPUT_IN_GAME_ACTION.JUMP]) > 0			 || keyboard_check(keyboard_keymap[INPUT_IN_GAME_ACTION.JUMP]);
	_input_in_game.dodge_held	= gamepad_button_check(last_gamepad_index, gamepad_keymap[INPUT_IN_GAME_ACTION.DODGE]) > 0			 || keyboard_check(keyboard_keymap[INPUT_IN_GAME_ACTION.DODGE]);
	_input_in_game.bow_shot_held= gamepad_button_check(last_gamepad_index, gamepad_keymap[INPUT_IN_GAME_ACTION.BOW_SHOT]) > 0		 || keyboard_check(keyboard_keymap[INPUT_IN_GAME_ACTION.BOW_SHOT]);
	_input_in_game.interact_held= gamepad_button_check(last_gamepad_index, gamepad_keymap[INPUT_IN_GAME_ACTION.INTERACT]) > 0		 || keyboard_check(keyboard_keymap[INPUT_IN_GAME_ACTION.INTERACT]);
	
	// notify
	if (_input_menu.any()) 
	{
		if (_should_notify) data_sets[INPUT_TYPE.MENU].notify();
	}
	
	if (_input_in_game.any()) 
	{
		if (_should_notify) data_sets[INPUT_TYPE.IN_GAME].notify()
	}
}

function update_input_source()
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

function gamepad_get_checked_key()
{
	for (var _i = gp_face1; _i <= gp_shoulderrb; _i++)
	{
		if (gamepad_button_check_pressed(last_gamepad_index, _i))
		{
			return _i;
		}
	}
	
	return false;
}

function keyboard_get_checked_key()
{
	var _keys = ds_map_keys_to_array(keyboard_button_sprites, []);
	
	for (var _i = 0; _i < array_length(_keys); _i++)
	{
		var _key = _keys[_i];
		
		if (keyboard_check_pressed(_key))
		{
			return _key;
		}
	}

	
	return false;
}

function gamepad_check_any()
{
	for (var _j = 0; _j < 8; _j++) // input indexes
	{
		for (var _i = gp_face1; _i <= gp_extra6; _i++)
		{
			if (gamepad_button_check(_j, _i)) 
			{
				last_gamepad_index = _j;
				last_gamepad_type  = get_gamepad_type(_j);
				
				global.logger.trace($"device: {last_gamepad_type}, index: {last_gamepad_index}");
				
				return true;
	        }
	    }
	
		if (gamepad_axis_value(_j, gp_axislh) < -axis_deadzone || gamepad_axis_value(_j, gp_axislh) > axis_deadzone
			|| gamepad_axis_value(_j, gp_axislv) < -axis_deadzone || gamepad_axis_value(_j, gp_axislv) > axis_deadzone)
		{
			last_gamepad_index = _j;
			last_gamepad_type  = get_gamepad_type(_j);
			
			return true;
		}
	}
	
	return false;
}

function get_gamepad_type(_gamepad_index = 0)
{
	var _description = string_lower(gamepad_get_description(_gamepad_index));
	
	if (string_pos("switch", _description) > 0) 
	{		
		return GAMEPAD_TYPE.SWITCH;
	}
	else if (string_pos("ps", _description) > 0)
	{
		return GAMEPAD_TYPE.PLAYSTATION;
	}
	else 
	{
		return GAMEPAD_TYPE.XBOX;
	}
}

function get_input_sprite_scale()
{
	return last_input_source_type == INPUT_SOURCE_TYPE.GAMEPAD ? 2 : 1.8;
}

function get_in_game_input()
{
	return data_sets[INPUT_TYPE.IN_GAME].input;
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