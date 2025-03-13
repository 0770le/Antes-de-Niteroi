event_inherited();

is_open				= false;
x					= 480 * 1.5;
y					= 270 * 1.5;
image_xscale		= 1;
image_yscale		= 1.1;
font				= fnt_arial_medium_to_large
font_description    = fnt_arial_medium;

root_menu			= noone;

x_padding			= 30;
y_padding			= 20;
x_level_padding		= 35;
y_level_padding		= 40;
selector_padding	= 12;

fullscreen_button   = noone;
volume_master       = noone;
volume_music		= noone;
volume_sfx          = noone;

title				= noone;

has_new_items		= false;

function open() {
	is_open = true;
	
	global.catalog_controller.close();
	
	global.initializer.focus(object_index);
	
	has_new_items = global.catalog_controller.has_new_item();
}

function close() {
	
	global.initializer.focus(noone);
	
	is_open = false;
	
	selected_item = root_menu.children[0];
}

function draw_parent()
{
	var _xx = get_sprite_center_x();
	
	draw_sprite_ext(spr_menu_title, 0, _xx, bbox_top + 70, 1.5, 1.1, 0, c_white, 1);
	
	draw_set_font(font);
	draw_set_color(c_white);
	draw_set_halign(fa_center);
	draw_set_valign(fa_top);
	
	draw_text(_xx, bbox_top + 88, selected_item.parent.title); 
}

function draw_item(_menu_item = new MenuItem(), _index = 0, _dual_column = false, _second_column = false)
{
	var _yyy = 300;
	
	draw_set_font(font_description);
	draw_set_color(c_white);
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	
	// any node
	var _xx = get_sprite_center_x();
	if (_dual_column)
	{
		_xx -= 150;
	}
	if (_second_column)
	{
		_xx += 300;
	}
	
	var _yy = _yyy + (_index * 70);
		
	draw_sprite_ext(spr_menu_button, _menu_item == selected_item ? 0 : 1, _xx, _yy, 1.2, 1.2, 0, c_white, 1);
		
	if (_menu_item.type == MENU_TYPE.CHECKBOX || _menu_item.type == MENU_TYPE.INTEGER || _menu_item.type == MENU_TYPE.INPUT)
	{
		draw_set_halign(fa_left);
		
		draw_text(_xx - 115, _yy, _menu_item.title);
	}
	else 
	{
		draw_text(_xx, _yy, _menu_item.title);
	}	
	
	// specific nodes
	if (_menu_item.type == MENU_TYPE.CATALOG)
	{
		if (has_new_items) draw_sprite_ext(spr_catalog_new_item, 0, _xx + 120, _yy, 0.35, 0.35, 0, c_white, 1);
	} 
	else if (_menu_item.type == MENU_TYPE.INPUT)
	{
		// how icon based on action key mapping		
		draw_sprite_ext(_menu_item.get_sprite(), 0, _xx + 120, _yy, 2, 2, 0, c_white, 1);
	} 
	else if (_menu_item.type == MENU_TYPE.CHECKBOX) 
	{
		var _checkbox_sprite = _menu_item.checked ? spr_checkbox_checked : spr_checkbox_unchecked;
		
		draw_sprite_ext(_checkbox_sprite, 0, _xx + 105, _yy, 0.25, 0.25, 0, c_white, 1);
	}
	else if (_menu_item.type == MENU_TYPE.INTEGER)
	{
		draw_set_halign(fa_right);
		
		draw_text(_xx + 100, _yy, $"{_menu_item.value}");
		
		if (_menu_item == selected_item)
		{
			var _selector = "<   >";
			
			if (_menu_item.value >= 10)
			{
				_selector = "<       ";
			}
			else if (_menu_item.value <= 0) 
			{
				_selector = "   >"
			}
			
			draw_text(_xx + 114, _yy, _selector);
		}
	}
}

function draw_controller_buttons()
{
	draw_set_color(c_black);
	draw_set_font(fnt_arial_medium_to_small);
	draw_set_valign(fa_middle);
	draw_set_halign(fa_right);
	
	var _scale = global.input_manager.get_input_sprite_scale();
	
	if (global.input_manager.is_capturing)
	{
		var _cancel_sprite = global.input_manager.get_menu_action_sprite(INPUT_MENU_ACTION.TOGGLE_MENU);
		
		draw_text(bbox_right - (sprite_get_width(_cancel_sprite)*_scale) - 60, bbox_bottom - 64, "Cancelar Captura");
		draw_sprite_ext(_cancel_sprite, 0, bbox_right - 50, bbox_bottom - 65, _scale, _scale, 0, c_white, 1.0);
	}
	else 
	{
		var _confirm_sprite = global.input_manager.get_menu_action_sprite(INPUT_MENU_ACTION.CONFIRM);
		var _cancel_sprite = global.input_manager.get_menu_action_sprite(INPUT_MENU_ACTION.CANCEL);
		var _toggle_sprite = global.input_manager.get_menu_action_sprite(INPUT_MENU_ACTION.TOGGLE_MENU);
	
		draw_text(bbox_right - (sprite_get_width(_toggle_sprite)*_scale) - 60, bbox_bottom - 134, "Fechar");
		draw_sprite_ext(_toggle_sprite, 0, bbox_right - 50, bbox_bottom - 133, _scale, _scale, 0, c_white, 1.0);
	
		draw_text(bbox_right - (sprite_get_width(_cancel_sprite)*_scale) - 60, bbox_bottom - 99, "Voltar");
		draw_sprite_ext(_cancel_sprite, 0, bbox_right - 50, bbox_bottom - 100, _scale, _scale, 0, c_white, 1.0);
	
		draw_text(bbox_right - (sprite_get_width(_confirm_sprite)*_scale) - 60, bbox_bottom - 64, "Confirmar");
		draw_sprite_ext(_confirm_sprite, 0, bbox_right - 50, bbox_bottom - 65, _scale, _scale, 0, c_white, 1.0);
	}
}

function draw_menu_items() 
{
	draw_controller_buttons();
	
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
	draw_set_color(c_black);

	draw_set_font(font);
	
	var _selected_group = selected_item.parent;
	
	draw_parent();
	
	array_foreach(_selected_group.children, function(_child, _index) 
	{ 
		draw_item(_child, _index, _child.parent.type == MENU_TYPE.TWO_COLUMNS_NODE);
	});
	
	if (_selected_group.type == MENU_TYPE.TWO_COLUMNS_NODE)
	{
		array_foreach(_selected_group.children_2, function(_child, _index) 
		{ 
			draw_item(_child, _index, true, true);
		});
	}
}

function on_input_key_map(_menu_item = new MenuInput(INPUT_IN_GAME_ACTION.JUMP), _keymap_input_model = new KeyMapInputModel())
{
	if (!_keymap_input_model.cancel)
	{
		if (_menu_item.input_source_type == INPUT_SOURCE_TYPE.GAMEPAD)
		{
			global.input_manager.set_gamepad_key_for_action(_menu_item.input_in_game_action, _keymap_input_model.key_pressed);
		}
		else 
		{
			global.input_manager.set_keyboard_key_for_action(_menu_item.input_in_game_action, _keymap_input_model.key_pressed);
		}
	}
	
	_menu_item.is_active = false;
}

function on_input_menu(_input = new MenuInputModel()) 
{
	if (!is_open)
	{
		if (_input.toggle_menu)
		{
			open();
		}
	
		return;
	}
	
	if (_input.toggle_menu)
	{
		selected_item = root_menu;
		
		close();
	}

	if (_input.confirm) 
	{
		switch (selected_item.type)
		{
			case MENU_TYPE.NODE:
			case MENU_TYPE.TWO_COLUMNS_NODE:
				selected_item = selected_item.children[0];
			
				break;
			case MENU_TYPE.LEAF:
				// do nothing
			
				break;
			case MENU_TYPE.BUTTON:
			case MENU_TYPE.CHECKBOX:
			case MENU_TYPE.CATALOG:
			case MENU_TYPE.INPUT:
				selected_item.on_click();
			
				break;
		}
	}
	
	if (_input.left || _input.right)
	{
		switch (selected_item.type)
		{
			case MENU_TYPE.SELECTOR:
			case MENU_TYPE.INTEGER:
				if (_input.left) selected_item.on_left();
				if (_input.right) selected_item.on_right();
			
				break;
			default:
				if (_input.left) selected_item = selected_item.left;
				if (_input.right) selected_item = selected_item.right;
			
				break;
		}
	}
	if (_input.up) selected_item = selected_item.previous; 
	if (_input.down) selected_item = selected_item.next;

	if (_input.cancel) 
	{
		if (selected_item.parent != selected_item.parent.parent)
		{
			selected_item = selected_item.parent;
		}
		else 
		{
			close();
		}
	}

	// play sounds	
	if (_input.left || _input.right || _input.up || _input.down) 
	{
		o_sound_controller.update_event_parameter_and_play(FMOD_EVENT.CROUCH, FMOD_PARAMETER_NAME_MOVE, FMOD_PARAMETER_MOVE_CROUCH.CROUCH);
	} 
	else if (_input.confirm || _input.toggle_menu || _input.cancel)
	{
		o_sound_controller.update_event_parameter_and_play(FMOD_EVENT.CROUCH, FMOD_PARAMETER_NAME_MOVE, FMOD_PARAMETER_MOVE_CROUCH.STAND);
	}
}

function on_options_change(_options = new OptionsModel())
{
	volume_master.set_value(_options.master_volume);
	volume_music.set_value(_options.music_volume);
	volume_sfx.set_value(_options.sfx_volume);
	
	fullscreen_button.set_checked(_options.fullscreen);
}

function init()
{
	global.menu_controller = self;
	
	root_menu = new MenuNode("Menu Principal");
	
	// Back to the Game
	root_menu.add_child(new MenuButton("Reiniciar Partida", function () 
	{
		game_restart();
	}));
	
	// Options	
	var _options_node = root_menu.add_child(new MenuNode("Opções"))
	fullscreen_button = _options_node.add_child(new MenuCheckbox("Tela Cheia", function ()
	{
		var _is_fullscreen = global.options_controller.get_option(OPTIONS_FULLSCREEN);
		
		// self.fullscreen_button.set_checked(!_is_fullscreen);
		
		global.options_controller.set_option(OPTIONS_FULLSCREEN, !_is_fullscreen);
	}));
	fullscreen_button.set_checked(global.options_controller.options.fullscreen);
	
	volume_master = _options_node.add_child(new MenuInteger("Volume Geral", 
	function ()
	{
		volume_master.set_value(volume_master.value - 1);
		
		global.options_controller.set_option(OPTIONS_MASTER_VOLUME, volume_master.value);
	}, 
	function () 
	{
		volume_master.set_value(volume_master.value + 1);
		
		global.options_controller.set_option(OPTIONS_MASTER_VOLUME, volume_master.value);
	}));
	volume_master.set_value(global.options_controller.options.master_volume);
	
	volume_music = _options_node.add_child(new MenuInteger("Música", 
	function ()
	{
		volume_music.set_value(volume_music.value - 1);
		
		global.options_controller.set_option(OPTIONS_MUSIC_VOLUME, volume_music.value);
	}, 
	function () 
	{
		volume_music.set_value(volume_music.value + 1);
		
		global.options_controller.set_option(OPTIONS_MUSIC_VOLUME, volume_music.value);
	}));
	volume_music .set_value(global.options_controller.options.music_volume);
	
	volume_sfx = _options_node.add_child(new MenuInteger("Efeitos", 
	function ()
	{
		volume_sfx.set_value(volume_sfx.value - 1);
		
		global.options_controller.set_option(OPTIONS_SFX_VOLUME, volume_sfx.value);
	}, 
	function () 
	{
		volume_sfx.set_value(volume_sfx.value + 1);
		
		global.options_controller.set_option(OPTIONS_SFX_VOLUME, volume_sfx.value);
	}));
	volume_sfx.set_value(global.options_controller.options.sfx_volume);
	
	// Catalog	
	root_menu.add_child(new MenuCatalog("Catálogo", function () 
	{
		global.menu_controller.close();
		
		global.catalog_controller.open();	
	}));
	
	// Key Mapping
	var _controls_node = root_menu.add_child(new MenuNode("Controles"))
	var _gamepad_node = _controls_node.add_child(new MenuNode("Gamepad"))
	_gamepad_node.add_child(new MenuInputGamepad(INPUT_IN_GAME_ACTION.JUMP));
	_gamepad_node.add_child(new MenuInputGamepad(INPUT_IN_GAME_ACTION.ATTACK));
	_gamepad_node.add_child(new MenuInputGamepad(INPUT_IN_GAME_ACTION.DODGE));
	_gamepad_node.add_child(new MenuInputGamepad(INPUT_IN_GAME_ACTION.BOW_SHOT));
	_gamepad_node.add_child(new MenuInputGamepad(INPUT_IN_GAME_ACTION.INTERACT));
	
	var _keyboard_node = _controls_node.add_child(new MenuTwoColumnsNode("Teclado"))
	_keyboard_node.add_child(new MenuInputKeyboard(INPUT_IN_GAME_ACTION.UP));
	_keyboard_node.add_child(new MenuInputKeyboard(INPUT_IN_GAME_ACTION.LEFT));
	_keyboard_node.add_child(new MenuInputKeyboard(INPUT_IN_GAME_ACTION.DOWN));
	_keyboard_node.add_child(new MenuInputKeyboard(INPUT_IN_GAME_ACTION.RIGHT));
	
	_keyboard_node.add_child_2(new MenuInputKeyboard(INPUT_IN_GAME_ACTION.JUMP));
	_keyboard_node.add_child_2(new MenuInputKeyboard(INPUT_IN_GAME_ACTION.ATTACK));
	_keyboard_node.add_child_2(new MenuInputKeyboard(INPUT_IN_GAME_ACTION.DODGE));
	_keyboard_node.add_child_2(new MenuInputKeyboard(INPUT_IN_GAME_ACTION.BOW_SHOT));
	_keyboard_node.add_child_2(new MenuInputKeyboard(INPUT_IN_GAME_ACTION.INTERACT));
	
	
	// Quit Game	
	root_menu.add_child(new MenuButton("Sair do Jogo", function() 
	{ 
		game_end(0); 
	}));
	
	selected_item = root_menu.children[0];
	
	global.input_manager.subscribe(self, INPUT_TYPE.MENU);
	global.input_manager.subscribe(self, INPUT_TYPE.KEY_MAP);
	global.options_controller.register_listener(self);
}

init();