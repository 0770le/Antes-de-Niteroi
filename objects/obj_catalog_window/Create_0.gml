enum CATALOG_TAB 
{
	BIODIVERSITY,
	HISTORY,
	REGIONS
}

x					= 480 * 1.5;
y					= 270 * 1.5;
image_xscale		= 1.5;
image_yscale		= 1.1;
is_open				= false;

catalog_tabs		= [];
catalog_items		= [];
selected_tab		= noone;

function open()
{
	is_open = true;
	
	global.initializer.focus(object_index);
	
	selected_tab.toggle_items(true);
	
	global.catalog_controller.show_all();
	
	selected_tab.selected_item.clear_new();
}

function has_new_item()
{
	for (var _i = 0; _i < array_length(catalog_tabs); ++_i) 
	{
		if (catalog_tabs[_i].has_new_item()) return true;
	}
	
	return false;
}

function close()
{
	is_open = false;
	
	selected_tab.toggle_items(false);
	
	global.initializer.focus(noone);
	
	global.catalog_controller.hide_all();
}

function draw_second_background() 
{
	draw_sprite_ext(spr_catalog_window_3, 0, bbox_right - 10, y, 0.95, 1, 0, c_white, 1.0);
	
	draw_controller_buttons();
	
	// draw_page_number();
}

function draw_controller_buttons()
{
	draw_set_color(c_black);
	draw_set_font(fnt_arial_medium_to_small);
	draw_set_valign(fa_middle);
	draw_set_halign(fa_right);
	
	var _cancel_sprite = global.input_manager.get_menu_action_sprite(INPUT_MENU_ACTION.CANCEL);
	var _toggle_sprite = global.input_manager.get_menu_action_sprite(INPUT_MENU_ACTION.TOGGLE_MENU);
	
	var _scale = global.input_manager.get_input_sprite_scale();
	
	// fechar e voltar
	draw_text(bbox_right - (sprite_get_width(_toggle_sprite)*_scale) - 60, bbox_bottom - 64, "Fechar");
	draw_sprite_ext(_toggle_sprite, 0, bbox_right - 50, bbox_bottom - 65, _scale, _scale, 0, c_white, 1.0);
	
	draw_text(bbox_right - (sprite_get_width(_cancel_sprite)*_scale) - 170, bbox_bottom - 64, "Voltar");
	draw_sprite_ext(_cancel_sprite, 0, bbox_right - 160, bbox_bottom - 65, _scale, _scale, 0, c_white, 1.0);
	
	// anterior e próxima aba
	var _tab_left_sprite = global.input_manager.get_menu_action_sprite(INPUT_MENU_ACTION.TAB_LEFT);
	var _tab_right_sprite = global.input_manager.get_menu_action_sprite(INPUT_MENU_ACTION.TAB_RIGHT);
	
	draw_text(bbox_right - (sprite_get_width(_tab_left_sprite)*_scale) - 420, bbox_bottom - 64, "Aba Anterior");
	draw_sprite_ext(_tab_left_sprite, 0, bbox_right - 410, bbox_bottom - 65, _scale, _scale, 0, c_white, 1.0);
	
	draw_text(bbox_right - (sprite_get_width(_tab_right_sprite)*_scale) - 270, bbox_bottom - 64, "Próxima Aba");
	draw_sprite_ext(_tab_right_sprite, 0, bbox_right - 260, bbox_bottom - 65, _scale, _scale, 0, c_white, 1.0);
}

function draw_page_number()
{
	if (!selected_tab.selected_item.locked)
	{
		draw_set_color(c_black);
		draw_set_font(fnt_arial_medium_to_small);
		draw_set_valign(fa_middle);
		draw_set_halign(fa_right);
	
		var _current_page = selected_tab.selected_item.get_current_page();
		var _total_pages = selected_tab.selected_item.get_number_of_pages();
	
		draw_text(bbox_right - 50, bbox_bottom - 135, $"Página {_current_page} de {_total_pages}");
	}
}

function on_input_menu(_input = new MenuInputModel())
{
	if (!is_open)
	{
		return;
	}
	
	if (_input.cancel) 
	{
		close();
		
		var _input_2 = new MenuInputModel();
		_input_2.toggle_menu = true;
			
		global.menu_controller.on_input_menu(_input_2);
		
		return;
	}
	
	if (_input.tab_left || _input.tab_right)
	{
		var _previous = selected_tab;
		
		selected_tab.set_selected(false);
		
		selected_tab = _input.tab_left ? selected_tab.previous : selected_tab.next;
		
		selected_tab.set_selected(true);
		
		if (_previous != selected_tab && _previous.selected_item != noone && selected_tab.selected_item != noone)
		{
			_previous.selected_item.set_hover(false);
			
			selected_tab.selected_item = selected_tab.items[0];
			
			selected_tab.selected_item.set_hover(true);
			
			selected_tab.selected_item.clear_new();
		}
	}
	
	if (_input.up || _input.down)
	{
		selected_tab.selected_item.set_hover(false);
		
		selected_tab.selected_item = _input.up ? selected_tab.selected_item.previous : selected_tab.selected_item.next;
		
		selected_tab.selected_item.set_hover(true);
		
		selected_tab.selected_item.clear_new();
	}
	
	if (_input.page_up) selected_tab.selected_item.previous_page();
	
	if (_input.page_down) selected_tab.selected_item.next_page();
	
	if (_input.debug_unlock) global.catalog_controller.unlock_item(selected_tab.selected_item.type);
	
	if (_input.debug_clear) global.catalog_controller.clear();
}

function draw_selected_item()
{
	selected_tab.selected_item.draw();
}

function create_content()
{
	//tabs
	//// regions items
	catalog_tabs[CATALOG_TAB.REGIONS] = instance_create_layer(bbox_right - 20, bbox_top + 10, LAYER_GUI_CATALOG_WINDOW, obj_catalog_tab);
	catalog_tabs[CATALOG_TAB.REGIONS].label	= "Regiões";
	var _last_item = catalog_tabs[CATALOG_TAB.REGIONS].add_item(instance_create_layer(bbox_left + 30, bbox_top + 48, LAYER_GUI_CATALOG_BUTTONS, obj_catalog_item));
	_last_item.label = "Cidade-Velha";
	_last_item.set_text("Situada entre a Pedra da Urca e a Cara de Cão, foi escolhida em 1567 como o ponto inicial de ocupação para a retomada da Baía dos Franceses. A topografia da região, com suas colinas e enseadas, oferecia um local ideal para a construção de fortificações.");
	_last_item.image = spr_catalog_cidade_velha;
	_last_item.type = CATALOG_ITEM_TYPE.CIDADE_VELHA;
	
	_last_item = catalog_tabs[CATALOG_TAB.REGIONS].add_item(instance_create_layer(_last_item.x, _last_item.bbox_bottom + 20, LAYER_GUI_CATALOG_BUTTONS, obj_catalog_item));
	_last_item.label = "Entrada Nova";
	_last_item.set_text("Texto da entrada nova");
	_last_item.image = spr_catalog_cidade_velha;
	_last_item.type = CATALOG_ITEM_TYPE.ENTRADA_NOVA;	
	catalog_tabs[CATALOG_TAB.REGIONS].set_selected(false);
	
	//// history items
	catalog_tabs[CATALOG_TAB.HISTORY] = instance_create_layer(catalog_tabs[CATALOG_TAB.REGIONS].bbox_left, catalog_tabs[CATALOG_TAB.REGIONS].y, LAYER_GUI_CATALOG_WINDOW, obj_catalog_tab);
	catalog_tabs[CATALOG_TAB.HISTORY].label	= "História";
	_last_item = catalog_tabs[CATALOG_TAB.HISTORY].add_item(instance_create_layer(bbox_left + 30, bbox_top + 48, LAYER_GUI_CATALOG_BUTTONS, obj_catalog_item));
	_last_item.label = "Morubixaba";
	_last_item.set_text("Apesar do uso do termo cacique pelos colonizadores europeus em toda a América, cada grupo indígena de diferentes regiões do continente possuía uma denominação e concepção próprias para suas lideranças.\nMburovixá é a denominação que os povos guaranis deram para seus líderes.\nJá para os tupis, as denominações eram morubixaba, murumuxaua, muruxaua, tubixaba e tuxaua.\nO termo curaca era usado para uma espécie de prefeito entre os povos incas de terras andinas no tempo da invasão promovida pela colonização europeia.");
	_last_item.image = spr_catalog_morubixaba;
	_last_item.type = CATALOG_ITEM_TYPE.MORUBIXABA;
	
	_last_item = catalog_tabs[CATALOG_TAB.HISTORY].add_item(instance_create_layer(_last_item.x, _last_item.bbox_bottom + 20, LAYER_GUI_CATALOG_BUTTONS, obj_catalog_item));
	_last_item.label = "Kunumĩuasu";
	_last_item.set_text("palavra de origem tupi-guarani que significa 'grande menino' ou 'grande jovem'. 'Kunumĩ' refere-se a menino, jovem ou rapaz, enquanto 'uasu' (ou 'guasu') significa grande. Além disso, também designa uma posição militar iniciante, atribuída a jovens guerreiros responsáveis por remar nas embarcações durante deslocamentos estratégicos. Essa função era essencial na organização e mobilidade dos grupos indígenas.");
	_last_item.image = spr_catalog_image;
	_last_item.type = CATALOG_ITEM_TYPE.KUNUMIUASU;
	catalog_tabs[CATALOG_TAB.HISTORY].set_selected(false);
	
	//// biodiversity items
	catalog_tabs[CATALOG_TAB.BIODIVERSITY] = instance_create_layer(catalog_tabs[CATALOG_TAB.HISTORY].bbox_left, catalog_tabs[CATALOG_TAB.REGIONS].y, LAYER_GUI_CATALOG_WINDOW, obj_catalog_tab);
	catalog_tabs[CATALOG_TAB.BIODIVERSITY].label = "Biodiversidade";
	_last_item = catalog_tabs[CATALOG_TAB.BIODIVERSITY].add_item(instance_create_layer(bbox_left + 30, bbox_top + 48, LAYER_GUI_CATALOG_BUTTONS, obj_catalog_item));
	_last_item.label = "Arariboia";
	_last_item.set_text("Arariboia (Niterói, 1520-1589) foi um chefe do povo temiminó, pertencente à etnia tupi, que habitava o litoral brasileiro no século XVI. Ao ser batizado pelos jesuítas, recebeu o nome cristão de Martim Afonso de Sousa, em homenagem ao donatário da Capitania de São Vicente, Martim Afonso de Sousa.\n"
		+ "Ficou conhecido na história devido à sua aliança com os portugueses, fundamental para a conquista da baía de Guanabara frente aos tamoios e franceses, em 1567.\n"
		+ "Como recompensa, recebeu da coroa portuguesa a propriedade de terras localizadas na entrada da baía de Guanabara.\n"
		+ "Ali foi estabelecida a aldeia de São Lourenço, que futuramente daria origem à cidade de Niterói, da qual é considerado o fundador.");
	_last_item.image = spr_catalog_arariboia;
	_last_item.type = CATALOG_ITEM_TYPE.ARARIBOIA;
	
	_last_item = catalog_tabs[CATALOG_TAB.BIODIVERSITY].add_item(instance_create_layer(_last_item.x, _last_item.bbox_bottom + 20, LAYER_GUI_CATALOG_BUTTONS, obj_catalog_item));
	_last_item.label = "Arara-canindé";
	_last_item.set_text("A arara-canindé (Ara ararauna) é uma ave impressionante, famosa por sua plumagem azul e amarela. Os tupinambás a adoravam, capturando-a viva para usar suas penas em rituais importantes, mas sem causar danos, soltando-a em seguida. Social e inteligente, essa arara tem um bico forte para quebrar sementes e desempenha um papel crucial na dispersão de sementes nas florestas tropicais.");
	_last_item.image = spr_catalog_caninde;
	_last_item.type = CATALOG_ITEM_TYPE.ARARA_CANINDE;
	
	_last_item = catalog_tabs[CATALOG_TAB.BIODIVERSITY].add_item(instance_create_layer(_last_item.x, _last_item.bbox_bottom + 20, LAYER_GUI_CATALOG_BUTTONS, obj_catalog_item));
	_last_item.label = "Armadeira";
	_last_item.set_text("A aranha-armadeira (Phoneutria) é considerada a mais venenosa do mundo, podendo atingir até 17 cm de comprimento. Conhecida por seu comportamento agressivo, é extremamente veloz e capaz de saltar até 40 cm. Quando ameaçada, adota uma postura defensiva característica,'se armando' ao levantar as patas dianteiras em posição de ataque.");
	_last_item.image = spr_catalog_armadeira;
	_last_item.type = CATALOG_ITEM_TYPE.ARMADEIRA;
	
	_last_item = catalog_tabs[CATALOG_TAB.BIODIVERSITY].add_item(instance_create_layer(_last_item.x, _last_item.bbox_bottom + 20, LAYER_GUI_CATALOG_BUTTONS, obj_catalog_item));
	_last_item.label = "Muçurana";
	_last_item.set_text("Pertence a família Dipsadidae. Seu porte vai de pequeno a médio,podendo chegar a medir 2,40 metros de comprimento quando alcançar a vida adulta.\nA sua coloração varia de acordo com a idade, possuindo uma coloração rosada com cabeça escura, quando jovem, e quando adultos são preto azuladas com uma faixa branca na parte ventral.\nApresenta veneno na sua peçonha mas não apresenta risco ao ser humano.");
	_last_item.image = spr_catalog_mucurana;
	_last_item.type = CATALOG_ITEM_TYPE.MUCURANA;
	
	catalog_tabs[CATALOG_TAB.BIODIVERSITY].set_selected(true);
	
	// tabs chaining
	catalog_tabs[CATALOG_TAB.REGIONS].previous = catalog_tabs[CATALOG_TAB.HISTORY];
	catalog_tabs[CATALOG_TAB.HISTORY].previous = catalog_tabs[CATALOG_TAB.BIODIVERSITY];
	catalog_tabs[CATALOG_TAB.BIODIVERSITY].next = catalog_tabs[CATALOG_TAB.HISTORY];
	catalog_tabs[CATALOG_TAB.HISTORY].next = catalog_tabs[CATALOG_TAB.REGIONS];
	
	
	// tab selection
	selected_tab = catalog_tabs[CATALOG_TAB.BIODIVERSITY];
	
	fill_catalog_items();
}

function fill_catalog_items()
{
	for (var _i = 0; _i < array_length(catalog_tabs); _i++)
	{
		for (var _j = 0; _j < array_length(catalog_tabs[_i].items); _j++)
		{
			array_push(catalog_items, catalog_tabs[_i].items[_j]);
		}
	}
}

function unlock_saved_items()
{
	global.logger.debug($"unlock_saved_items length {array_length(global.options_controller.options.unlocked_catalog_items)}");
	
	with (obj_catalog_item)
	{
		global.logger.debug($"unlock_saved_items type: {self.type}");
		
		if (array_contains(global.options_controller.options.unlocked_catalog_items, type))
		{
			locked = false;	
			
			if (!array_contains(global.options_controller.options.checked_catalog_items, type))
			{
				is_new = true;
			}
		}
	}
}

function init()
{
	create_content();
	
	unlock_saved_items();
	
	close();
	
	global.input_manager.subscribe(self, INPUT_TYPE.MENU);
}

init();