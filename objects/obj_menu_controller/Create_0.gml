toggle_key			= vk_f10;
is_open				= false;
x					= 320;
y					= 180;
image_xscale		= 16 / 2;
image_yscale		= 9 / 2;
font				= fnt_arial_medium_to_small;
font_description    = fnt_arial_small;

root_menu			= noone;

x_padding			= 20;
y_padding			= 20;
x_level_padding		= 14;
y_level_padding		= 20;
selector_padding	= 12;

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

function open() {
	is_open = true;
	
	instance_deactivate_all(true);
}

function close() {
	instance_activate_all();
	
	is_open = false;
	
	selected_item = root_menu.children[0];
}

function init()
{
	global.menu_controller = self;
	
	root_menu = new MenuNode("Menu Principal");
	root_menu.add_child(new MenuButton("Voltar ao Jogo", close));
	
	var _log_node = root_menu.add_child(new MenuNode("Registros"));
	
	var _biodiversity_node = _log_node.add_child(new MenuNode("Biodiversidade"));
	
	var _arara_caninde_node = _biodiversity_node.add_child(new MenuNode("Arara-canindé"));
	_arara_caninde_node.add_child(
		new MenuLeaf(
			"A arara-canindé (Ara ararauna) é uma ave impressionante, famosa por sua plumagem azul e amarela. Os tupinambás a adoravam, capturando-a viva para usar suas penas em rituais importantes, mas sem causar danos, soltando-a em seguida. Social e inteligente, essa arara tem um bico forte para quebrar sementes e desempenha um papel crucial na dispersão de sementes nas florestas tropicais.",
			s_jararaca_idle
		)
	);
	
	var _aranha_armadeira_node = _biodiversity_node.add_child(new MenuNode("Armadeira"));
	_aranha_armadeira_node.add_child(
		new MenuLeaf(
			"A aranha-armadeira (Phoneutria) é considerada a mais venenosa do mundo, podendo atingir até 17 cm de comprimento. Conhecida por seu comportamento agressivo, é extremamente veloz e capaz de saltar até 40 cm. Quando ameaçada, adota uma postura defensiva característica,'se armando' ao levantar as patas dianteiras em posição de ataque.",
			s_armadeira_idle
		)
	);
	
	var _frances_node = _biodiversity_node.add_child(new MenuNode("Francês"));
	_frances_node.add_child(
		new MenuLeaf(
			"Franceses são inimigos!",
			s_frances_idle
		)
	);
	
	var _regions_node = _log_node.add_child(new MenuNode("Regiões"));
	var _cidade_velha_node = _regions_node.add_child(new MenuNode("Cidade-Velha"));
	_cidade_velha_node.add_child(
		new MenuLeaf(
			"Situada entre a Pedra da Urca e a Cara de Cão, foi escolhida em 1567 como o ponto inicial de ocupação para a retomada da Baía dos Franceses. A topografia da região, com suas colinas e enseadas, oferecia um local ideal para a construção de fortificações."
		)
	);
	
	var _history_node = _log_node.add_child(new MenuNode("História"))
	
	var _nova_historia_node = _history_node.add_child(new MenuNode("Nova História"));
	_nova_historia_node.add_child(
		new MenuLeaf(
			"Lorem ipsum dolor sit amet, consectetur adipiscing elit. In non lacus ac nunc elementum euismod. Phasellus eros diam, convallis quis lorem eu, aliquam viverra lorem. Donec dapibus odio eu ipsum sagittis, sed convallis turpis finibus. Mauris id mollis augue. Vestibulum egestas nisl id lorem egestas, in efficitur justo rutrum. Proin eu leo quis justo bibendum accumsan eu non lorem. Vivamus consectetur sem nulla, nec tempor elit consequat sed."
		)
	);
	
	root_menu.add_child(new MenuCheckbox("Tela Cheia", function ()
	{
		var _is_fullscreen = global.options_controller.get_option(OPTIONS_FULLSCREEN);
		
		self.checked = !_is_fullscreen;
		
		global.options_controller.set_option(OPTIONS_FULLSCREEN, !_is_fullscreen);
	}));
	
	root_menu.add_child(new MenuButton("Sair do Jogo", function() 
	{ 
		game_end(0); 
	}));
	
	selected_item = root_menu.children[0];
}

init();