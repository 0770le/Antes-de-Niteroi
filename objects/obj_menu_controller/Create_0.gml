event_inherited();

is_open				= false;
x					= 480 * 1.5;
y					= 270 * 1.5;
image_xscale		= 1;
image_yscale		= 1.1;
left				= bbox_left;
right				= bbox_right;
top					= bbox_top;
bottom				= bbox_bottom;

x_padding			= 30;
y_padding			= 20;
x_level_padding		= 35;
y_level_padding		= 40;
selector_padding	= 12;

fullscreen_button   = noone;
volume_master       = noone;
volume_music		= noone;
volume_sfx          = noone;
deaf_assistance		= noone;

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

function on_input_key_map(_menu_item = new MenuInput(INPUT_IN_GAME_ACTION.JUMP), _keymap_input_model = new KeyMapInputModel())
{
	if (!_keymap_input_model.cancel)
	{
		global.sound_controller.play(FMOD_EVENT.MENU_CONFIRM_RETURN);
		
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

function on_options_change(_options = new OptionsModel())
{
	volume_master.set_value(_options.master_volume);
	volume_music.set_value(_options.music_volume);
	volume_sfx.set_value(_options.sfx_volume);
	
	fullscreen_button.set_checked(_options.fullscreen);
	deaf_assistance.set_checked(_options.deaf_assistance);
}

function init()
{
	global.menu_controller = self;
	
	root_menu = new MenuNode("Menu Principal");
	
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
	deaf_assistance = _options_node.add_child(new MenuCheckbox("Ajuda para Surdos", function ()
	{
		var _is_deaf_assistance = global.options_controller.get_option(OPTIONS_DEAF_ASSISTANCE);
		
		global.options_controller.set_option(OPTIONS_DEAF_ASSISTANCE, !_is_deaf_assistance);
	}));
	deaf_assistance.set_checked(global.options_controller.options.deaf_assistance);
	
	// Catalog	
	root_menu.add_child(new MenuCatalog("Catálogo", function () 
	{
		global.sound_controller.play(FMOD_EVENT.MENU_CONFIRM_RETURN);
		
		global.menu_controller.close();
		
		global.catalog_controller.open();	
	}));
	
	// Key Mapping
	var _controls_node = root_menu.add_child(new MenuNode("Controles"))
	var _gamepad_node = _controls_node.add_child(new MenuTwoColumnsNode("Gamepad"))
	_gamepad_node.add_child(new MenuButton("Usar o Padrão", function ()
	{
		global.input_manager.gamepad_keymap = new OptionsModel().gamepad_keymap;
		
		global.options_controller.set_option(OPTIONS_GAMEPAD_KEYMAP, global.input_manager.gamepad_keymap);
	}));
	_gamepad_node.add_child_2(new MenuInputGamepad(INPUT_IN_GAME_ACTION.JUMP));
	_gamepad_node.add_child_2(new MenuInputGamepad(INPUT_IN_GAME_ACTION.ATTACK));
	_gamepad_node.add_child_2(new MenuInputGamepad(INPUT_IN_GAME_ACTION.DODGE));
	_gamepad_node.add_child_2(new MenuInputGamepad(INPUT_IN_GAME_ACTION.BOW_SHOT));
	_gamepad_node.add_child_2(new MenuInputGamepad(INPUT_IN_GAME_ACTION.INTERACT));
	
	var _keyboard_node = _controls_node.add_child(new MenuTwoColumnsNode("Teclado"))
	_keyboard_node.add_child(new MenuButton("Usar o Padrão", function ()
	{
		global.input_manager.keyboard_keymap = new OptionsModel().keyboard_keymap;
		
		global.options_controller.set_option(OPTIONS_KEYBOARD_KEYMAP, global.input_manager.keyboard_keymap);
	}));
	_keyboard_node.add_child(new MenuInputKeyboard(INPUT_IN_GAME_ACTION.UP));
	_keyboard_node.add_child(new MenuInputKeyboard(INPUT_IN_GAME_ACTION.LEFT));
	_keyboard_node.add_child(new MenuInputKeyboard(INPUT_IN_GAME_ACTION.DOWN));
	_keyboard_node.add_child(new MenuInputKeyboard(INPUT_IN_GAME_ACTION.RIGHT));
	
	_keyboard_node.add_child_2(new MenuInputKeyboard(INPUT_IN_GAME_ACTION.JUMP));
	_keyboard_node.add_child_2(new MenuInputKeyboard(INPUT_IN_GAME_ACTION.ATTACK));
	_keyboard_node.add_child_2(new MenuInputKeyboard(INPUT_IN_GAME_ACTION.DODGE));
	_keyboard_node.add_child_2(new MenuInputKeyboard(INPUT_IN_GAME_ACTION.BOW_SHOT));
	_keyboard_node.add_child_2(new MenuInputKeyboard(INPUT_IN_GAME_ACTION.INTERACT));
	
	// Créditos
	var _credits_node = root_menu.add_child(new MenuNode("Créditos"))
	_credits_node.add_child(new MenuCredits(
		"Créditos", 
		
		"Projetista e Desenvolvedor: Otto Lehmann\n" + 
		"Artista Gráfico: Leonardo Marques\n" + 
		"Artista de Som: André Rente\n" +
		"Desenvolvedor: Augusto Escobar\n" +
		"Historiador: Fulano de Tal\n",
		
		"Referencias:\n" + 
		"O Rio antes do Rio, por Rafael Freitas da Silva"
	));
	
	// Quit Game	
	root_menu.add_child(new MenuButton("Menu Inicial", function() 
	{ 
		//global.initializer.focus(noone);
		
		global.fader.to_room(rm_main_menu);
	}));
	
	selected_item = root_menu.children[0];
	
	global.input_manager.subscribe(self, INPUT_TYPE.MENU);
	global.input_manager.subscribe(self, INPUT_TYPE.KEY_MAP);
	global.options_controller.register_listener(self);
}

init();