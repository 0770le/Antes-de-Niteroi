event_inherited();

is_open				= false;
x					= 320;
y					= 180;
image_xscale		= 16 / 5;
image_yscale		= 9 / 4;
font				= fnt_arial_medium_to_small;
font_description    = fnt_arial_small;

root_menu			= noone;

x_padding			= 20;
y_padding			= 20;
x_level_padding		= 14;
y_level_padding		= 20;
selector_padding	= 12;

fullscreen_button   = noone;
volume_master       = noone;
volume_music		= noone;
volume_sfx          = noone;

function open() {
	is_open = true;
	
	global.catalog_controller.close();
	
	global.initializer.focus(object_index);
}

function close() {
	
	global.initializer.focus(noone);
	
	is_open = false;
	
	selected_item = root_menu.children[0];
}

function draw_pointer(_position = 0)
{
	draw_text(
		bbox_left + x_padding, 
		bbox_top + y_padding + (1 + _position) * y_level_padding, 
		">>>"); 
}

function draw_parent()
{
	draw_set_font(font);
	
	draw_text(bbox_left + x_padding, bbox_top + y_padding, selected_item.parent.title); 
}

function draw_item(_menu_item = new MenuItem(), _index = 0)
{
	draw_set_font(font_description);
	draw_set_color(c_black);
	
	if (_menu_item.type == MENU_TYPE.LEAF)
	{
		var _sprite_padding = 0;
		
		if (_menu_item.sprite != noone)
		{
			var _sprite_x = bbox_left + 46;
			var _sprite_y = bbox_top + 66;
			var _sprite_width = 24;
			var _sprite_height = 24;
				
			draw_rectangle(
				_sprite_x - _sprite_width, 
				_sprite_y - _sprite_height, 
				_sprite_x + _sprite_width, 
				_sprite_y + _sprite_height, true);
		
			draw_sprite(_menu_item.sprite, 0, _sprite_x, _sprite_y);
			
			_sprite_padding += _sprite_width + 20;
		}
		
		draw_text_ext(
			bbox_left + x_padding + x_level_padding + _sprite_padding, 
			bbox_top + y_padding + (1 + _index) * y_level_padding, 
			_menu_item.title, 15, 420);
	}
	else 
	{
		draw_text(
			bbox_left + x_padding + x_level_padding + selector_padding, 
			bbox_top + y_padding + (1 + _index) * y_level_padding, 
			_menu_item.title); 
	}
	
	if (_menu_item.type == MENU_TYPE.CHECKBOX) 
	{
		draw_text_ext(
			bbox_right - 40, 
			bbox_top + y_padding + (1 + _index) * y_level_padding, 
			_menu_item.checked ? "V" : "X", 15, 420);
	}
	
	if (_menu_item.type == MENU_TYPE.INTEGER)
	{
		draw_text_ext(
			bbox_right - 40, 
			bbox_top + y_padding + (1 + _index) * y_level_padding, 
			_menu_item.value, 15, 420);
	}
}

function draw_menu_items() 
{
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
	draw_set_color(c_black);

	draw_set_font(font);
	
	var _selected_group = selected_item.parent;
	
	draw_parent();
	
	array_foreach(_selected_group.children, function(_child, _index) 
	{ 
		draw_item(_child, _index);
		
		if (_child == selected_item && _child.type != MENU_TYPE.LEAF)
		{
			draw_pointer(_index);
		}
	});
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
				selected_item = selected_item.children[0];
			
				break;
			case MENU_TYPE.LEAF:
				// do nothing
			
				break;
			case MENU_TYPE.BUTTON:
			case MENU_TYPE.CHECKBOX:
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
}

function on_options_change(_options = new OptionsModel())
{
	volume_master.set_value(_options.master_volume);
	volume_music.set_value(_options.music_volume);
	volume_sfx.set_value(_options.sfx_volume);
}

function init()
{
	global.menu_controller = self;
	
	root_menu = new MenuNode("Menu Principal");
	
	// Back to the Game
	root_menu.add_child(new MenuButton("Voltar ao Jogo", close));
	
	root_menu.add_child(new MenuButton("Catálogo", function () 
	{
		global.catalog_controller.open();	
	}));
	
	// Options	
	var _options_node = root_menu.add_child(new MenuNode("Opções"))
	fullscreen_button = _options_node.add_child(new MenuCheckbox("Tela Cheia", function ()
	{
		var _is_fullscreen = global.options_controller.get_option(OPTIONS_FULLSCREEN);
		
		self.fullscreen_button.set_checked(!_is_fullscreen);
		
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
	
	volume_sfx = _options_node.add_child(new MenuInteger("Efeitos Sonoros", 
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
	
	// Quit Game	
	root_menu.add_child(new MenuButton("Sair do Jogo", function() 
	{ 
		game_end(0); 
	}));
	
	selected_item = root_menu.children[0];
	
	global.input_manager.subscribe(self, INPUT_TYPE.MENU);
	global.options_controller.register_listener(self);
}

init();