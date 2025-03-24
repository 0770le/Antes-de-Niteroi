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
	
	selected_tab.selected_item.clear_new();
	
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
		
		selected_tab.selected_item.clear_new();
		
		selected_tab = _input.tab_left ? selected_tab.previous : selected_tab.next;
		
		selected_tab.set_selected(true);
		
		if (_previous != selected_tab && _previous.selected_item != noone && selected_tab.selected_item != noone)
		{
			_previous.selected_item.set_hover(false);
			
			//selected_tab.selected_item = selected_tab.items[0];
			
			selected_tab.selected_item.set_hover(true);
			
			selected_tab.toggle_items(true);
		}
	}
	
	if (_input.up || _input.down)
	{
		selected_tab.selected_item.set_hover(false);
		
		var _previous_index = selected_tab.selected_item.index;
		
		selected_tab.selected_item.clear_new();
		
		selected_tab.selected_item = _input.up ? selected_tab.selected_item.previous : selected_tab.selected_item.next;
		
		var _current_index = selected_tab.selected_item.index;
		
		selected_tab.update_cursor(_previous_index, _current_index);
		
		selected_tab.selected_item.set_hover(true);
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

function draw_item_cursor_arrows()
{
	var _input = global.input_manager.get_menu_input();
	
	if (selected_tab.min_display_index > 0)
	{
		var _xx = selected_tab.selected_item.bbox_left + ((sprite_get_width(selected_tab.selected_item.sprite_index) * selected_tab.selected_item.image_xscale)/2);
		var _yy = bbox_top + 50;
		
		var _up_arrow_frame = _input.up_held ? 1 : 0;
		
		draw_sprite_ext(spr_catalog_arrow_up, _up_arrow_frame, _xx, _yy, 1.5, 1.5, 0, c_white, 1);
	}
	
	if (selected_tab.max_display_index < array_length(selected_tab.items) - 1)
	{
		var _xx = selected_tab.selected_item.bbox_left + ((sprite_get_width(selected_tab.selected_item.sprite_index) * selected_tab.selected_item.image_xscale)/2);
		var _yy = bbox_bottom - 50;
		
		var _down_arrow_frame = _input.down_held ? 1 : 0;
		
		draw_sprite_ext(spr_catalog_arrow_down, _down_arrow_frame, _xx, _yy, 1.5, 1.5, 0, c_white, 1);
	}
}

function create_content()
{
	//tabs
	//// regions items
	catalog_tabs[CATALOG_TAB.REGIONS] = instance_create_layer(bbox_right - 20, bbox_top + 10, LAYER_GUI_CATALOG_WINDOW, obj_catalog_tab);
	catalog_tabs[CATALOG_TAB.REGIONS].label	= "Regiões";
	var _last_item = catalog_tabs[CATALOG_TAB.REGIONS].add_item(instance_create_layer(0, 0, LAYER_GUI_CATALOG_BUTTONS, obj_catalog_item));
	_last_item.label = "Guajupiá";
	_last_item.set_text("Baía de Guanabara (RJ). Guajupiá, 'morada dos ancestrais', era para os tupinambás uma espécie de paraíso, onde descansavam os antepassados mais valorosos e memoráveis. Ao chegarem à região, após descerem pelo litoral brasileiro e conquistarem territórios de outras tribos, passaram a chamá-la assim devido a sua abundância em frutos, peixes e recursos naturais.");
	_last_item.image = spr_catalog_cidade_velha;
	_last_item.type = CATALOG_ITEM_TYPE.GUAJUPIA;
	
	_last_item = catalog_tabs[CATALOG_TAB.REGIONS].add_item(instance_create_layer(0, 0, LAYER_GUI_CATALOG_BUTTONS, obj_catalog_item));
	_last_item.label = "Cidade Velha";
	_last_item.set_text("Atual Praia de Fora (RJ). Situada entre a Pedra da Urca e a Cara de Cão, foi escolhida em 1567 como o ponto inicial de ocupação para a retomada da Baía dos Franceses. A topografia da região, com suas colinas e enseadas, oferecia um local ideal para a construção de fortificações.");
	_last_item.image = spr_catalog_cidade_velha;
	_last_item.type = CATALOG_ITEM_TYPE.CIDADE_VELHA;
	
	_last_item = catalog_tabs[CATALOG_TAB.REGIONS].add_item(instance_create_layer(0, 0, LAYER_GUI_CATALOG_BUTTONS, obj_catalog_item));
	_last_item.label = "Nheteróia";
	_last_item.set_text("Para os tupinambás, o nome original do Rio de Janeiro seria Niterói. Há indícios de que esse nome também serviria para designavar toda a costa da baía e uma aldeia na margem direita da mesma. Sua etimologia pode significar tanto 'costa toda sinuosa' quanto 'rio escondido'.");
	_last_item.image = spr_catalog_cidade_velha;
	_last_item.type = CATALOG_ITEM_TYPE.NHETEROIA;	
	
	_last_item = catalog_tabs[CATALOG_TAB.REGIONS].add_item(instance_create_layer(0, 0, LAYER_GUI_CATALOG_BUTTONS, obj_catalog_item));
	_last_item.label = "Keriy";
	_last_item.set_text("Atual Saco de São Francisco, Niterói (RJ). O nome dessa taba é referência as ostras que se reproduziam nas águas idealmente calmas desse vale. Ainda nos dias de hoje a região produz ostras como atividade econômica." );
	_last_item.image = spr_catalog_cidade_velha;
	_last_item.type = CATALOG_ITEM_TYPE.KERIY;	
	
	_last_item = catalog_tabs[CATALOG_TAB.REGIONS].add_item(instance_create_layer(0, 0, LAYER_GUI_CATALOG_BUTTONS, obj_catalog_item));
	_last_item.label = "Akaray";
	_last_item.set_text("Atual bairro de Icaraí, Niterói (RJ). A região formava um enorme areal com vegetação típica de restinga. Seu nome deriva do peixe de água doce acará ou cará, significando algo como 'Rio dos Acarás'");
	_last_item.image = spr_catalog_cidade_velha;
	_last_item.type = CATALOG_ITEM_TYPE.AKARAY;	
	
	_last_item = catalog_tabs[CATALOG_TAB.REGIONS].add_item(instance_create_layer(0, 0, LAYER_GUI_CATALOG_BUTTONS, obj_catalog_item));
	_last_item.label = "Morgujá-uausú";
	_last_item.set_text("Atual Centro de Niterói (RJ). A taba de nome 'Maracujá Grande' se devia ao fato da região ter apresentado grande fartura da fruta cítrica e doce que curava o escorbuto dos marinheiros recém chegados das longas viagens pelo oceano.");
	_last_item.image = spr_catalog_cidade_velha;
	_last_item.type = CATALOG_ITEM_TYPE.MORGUJA_UASU;	
	
	_last_item = catalog_tabs[CATALOG_TAB.REGIONS].add_item(instance_create_layer(0, 0, LAYER_GUI_CATALOG_BUTTONS, obj_catalog_item));
	_last_item.label = "Kurumuré";
	_last_item.set_text("Atual área entre o rio Maruí e o bairro de Neves, Niterói(RJ). A 'taba das Taínhas' atestava a grande importancia desse peixe para a comunidade tupinambá. Eles as pescavam usando flechas e usavam sua carne para preparar uma 'farinha de guerra' altamente durável e nutritiva, que servia como sustento aos guerreiros durante missões em busca de inimigos distantes." );
	_last_item.image = spr_catalog_cidade_velha;
	_last_item.type = CATALOG_ITEM_TYPE.KURUMURE;
	
	_last_item = catalog_tabs[CATALOG_TAB.REGIONS].add_item(instance_create_layer(0, 0, LAYER_GUI_CATALOG_BUTTONS, obj_catalog_item));
	_last_item.label = "Itaóka";
	_last_item.set_text("Atual bairro de Itaoca, São Gonçado (RJ). A aldeia da 'Casa de Pedra' provavelmente levou esse nome devio a referência alguma pedra grande ou ao fato de que suas malocas estariam enconstadas em relevos de granito. O litoral de Itaóka era chamado de Suaçuna, referência ao sûasu, cervo para os tupinambás." );
	_last_item.image = spr_catalog_cidade_velha;
	_last_item.type = CATALOG_ITEM_TYPE.ITAOKA;
	
	_last_item = catalog_tabs[CATALOG_TAB.REGIONS].add_item(instance_create_layer(0, 0, LAYER_GUI_CATALOG_BUTTONS, obj_catalog_item));
	_last_item.label = "Itaóka - Último Bastião";
	_last_item.set_text("A terceira e última fortaleza dos tamoios na baía de Guanabara. Foi para a costa de suaçuna, área conhecida como 'porto dos franceses', que franceses e tupinambas recuaram após a derrota na batalha de Paranapucu. Na aldeia de Itaóka se erguia três cercas fortissímas com muitos baluartes e casas fortes. Essa fortaleza servia estrategicamente para guardar uma rota de retirada para a reorganização dos efetivos nativos no Cabo Frio." );
	_last_item.image = spr_catalog_cidade_velha;
	_last_item.type = CATALOG_ITEM_TYPE.ITAOKA_FORT;
	
	_last_item = catalog_tabs[CATALOG_TAB.REGIONS].add_item(instance_create_layer(0, 0, LAYER_GUI_CATALOG_BUTTONS, obj_catalog_item));
	_last_item.label = "Ilha de Seregipe";
	_last_item.set_text("Atual Ilha de Villegagnon (RJ), anexada ao Aeroporto Santos Dumont. Na Ilha de Serigipe ficava localizado o Forte Coligny, centro do assentamento colonial francês chamado França Antártica (1555-1560), liderado por Nicolas Durand de Villegagnon (1510-1571). " );
	_last_item.image = spr_catalog_cidade_velha;
	_last_item.type = CATALOG_ITEM_TYPE.SEREGIPE;
	
	_last_item = catalog_tabs[CATALOG_TAB.REGIONS].add_item(instance_create_layer(0, 0, LAYER_GUI_CATALOG_BUTTONS, obj_catalog_item));
	_last_item.label = "Karióca";
	_last_item.set_text("Atualmente o que conhecemos como Flamengo, Laranjeiras, Largo do Machado, Catete e Glória (RJ). O rio carioca herdou o nome da taba: 'casa dos (indígenas) cariós'. Os cariós eram uma tribo rival que compartilhava língua e costumes com tupinambas. Em Karióca viviam cativos até que se realizassem os rituais antropofágicos. Era uma comunidade tupi enorme com muitas malocas e foi a comunidade que mais interagiu e auxiliou os franceses do forte Coligny." );
	_last_item.image = spr_catalog_cidade_velha;
	_last_item.type = CATALOG_ITEM_TYPE.KARIOCA;
	
	_last_item = catalog_tabs[CATALOG_TAB.REGIONS].add_item(instance_create_layer(0, 0, LAYER_GUI_CATALOG_BUTTONS, obj_catalog_item));
	_last_item.label = "Karióca - Reri’pê";
	_last_item.set_text("Alto do atual Morro da Glória (RJ). Com o apoio e a orientação de alguns franceses, os tupinambás construíram uma grande cerca de madeira, equipada com torres para armas de fogo, além de possuírem diversas espingardas. Na praia, haviam cavado fossos armados com estrepes como armadilhas. Chamado pelos nativos de rery-pê, lugar das ostras, ali se encontrava a primeira fortaleza tupinambá enfrentada pelos temiminós e portugueses na grande batalha de Uruçumirim. Durante essa batalha Estácio de Sá, mesmo usando sua armadura completa, foi mortalmente ferido por uma flecha inimiga." );
	_last_item.image = spr_catalog_cidade_velha;
	_last_item.type = CATALOG_ITEM_TYPE.RERI_PE;
	
	_last_item = catalog_tabs[CATALOG_TAB.REGIONS].add_item(instance_create_layer(0, 0, LAYER_GUI_CATALOG_BUTTONS, obj_catalog_item));
	_last_item.label = "Gûyragûasu’unaê";
	_last_item.set_text("Atual Centro da cidade do Rio de Janeiro (RJ). Gûyragûasu’unaê é a Harpia, 'o grande passaro negro'. Nome do seu lider, e por extensão sua aldeia, é como chamavam uma ave de rapina gigantesca que habitava a Guanabara." );
	_last_item.image = spr_catalog_cidade_velha;
	_last_item.type = CATALOG_ITEM_TYPE.GUYRAGUASU_UNAE;
	
	_last_item = catalog_tabs[CATALOG_TAB.REGIONS].add_item(instance_create_layer(0, 0, LAYER_GUI_CATALOG_BUTTONS, obj_catalog_item));
	_last_item.label = "Jabebiracica";
	_last_item.set_text("Atual Rio Comprido e São Cristovão (RJ).  A taba da 'Arraia Cortada', possivelmente se referenciando ao peixe-viola. Estava em posição estratégica pois por ela passavam diversas rotas indígenas." );
	_last_item.image = spr_catalog_cidade_velha;
	_last_item.type = CATALOG_ITEM_TYPE.JABEBIRACICA;
	
	_last_item = catalog_tabs[CATALOG_TAB.REGIONS].add_item(instance_create_layer(0, 0, LAYER_GUI_CATALOG_BUTTONS, obj_catalog_item));
	_last_item.label = "Paranãpuã";
	_last_item.set_text("Atual Ilha do Governador (RJ). Seu nome se traduz por 'Ilha do Mar'. Era um local priveligiado dentro da Guanabara pela fartura em água doce e por seus mares calmos, por isso era um território disputado apesar de ser conhecidamente território de onças. Era conhecida como 'Ilha do gato' pois era ocupada pelos marakaîás, 'gatos-do-mato', na época que os portugueses chegaram pela primeira vez na baía. Era a tribo a qual pertencia Arariboia e de identificariam como Temiminós. O território foi tomado pelos Tamoios que lá ergueram uma fortaleza." );
	_last_item.image = spr_catalog_cidade_velha;
	_last_item.type = CATALOG_ITEM_TYPE.PARANAPUA;
	
	_last_item = catalog_tabs[CATALOG_TAB.REGIONS].add_item(instance_create_layer(0, 0, LAYER_GUI_CATALOG_BUTTONS, obj_catalog_item));
	_last_item.label = "Paranãpuã - Paranacupu";
	_last_item.set_text("O assalto a fortaleza localizada na taba de Paranacupu,'Mar Comprido', durou três dias e envolveu milhares de guerreiros e muita artilharia. Lá foi construida uma fortaleza dos tamoios ainda maior que a de Reri-pê. Quando foi tomada por temiminós e portugueses, os indígenas recuaram para Itaóka." );
	_last_item.image = spr_catalog_cidade_velha;
	_last_item.type = CATALOG_ITEM_TYPE.PARANACUPU;
	
	
	
	catalog_tabs[CATALOG_TAB.REGIONS].set_selected(false);
	
	//// history items
	catalog_tabs[CATALOG_TAB.HISTORY] = instance_create_layer(catalog_tabs[CATALOG_TAB.REGIONS].bbox_left, catalog_tabs[CATALOG_TAB.REGIONS].y, LAYER_GUI_CATALOG_WINDOW, obj_catalog_tab);
	catalog_tabs[CATALOG_TAB.HISTORY].label	= "História";
	_last_item = catalog_tabs[CATALOG_TAB.HISTORY].add_item(instance_create_layer(0, 0, LAYER_GUI_CATALOG_BUTTONS, obj_catalog_item));
	_last_item.label = "Morubixaba";
	_last_item.set_text("Título conferido ao grande chefe, o 'principal' de uma taba. Esse posto era reservado a indígenas com mais de 40 anos, que haviam acumulado vasta experiência em batalhas e conquistado prestígio por seus feitos em combate. Eram escolhidos como líderes de expedições militares e participavam de conselhos líderes de outros agrupamentos.");
	_last_item.image = spr_catalog_morubixaba;
	_last_item.type = CATALOG_ITEM_TYPE.MORUBIXABA;
	
	_last_item = catalog_tabs[CATALOG_TAB.HISTORY].add_item(instance_create_layer(0, 0, LAYER_GUI_CATALOG_BUTTONS, obj_catalog_item));
	_last_item.label = "Kunumĩuasu";
	_last_item.set_text("Palavra de origem tupi-guarani que significa 'grande menino' ou 'grande jovem'. 'Kunumĩ' refere-se a menino, jovem ou rapaz, enquanto 'uasu' (ou 'guasu') significa grande. Além disso, também designa uma posição militar iniciante, atribuída a jovens guerreiros responsáveis por remar as canoas durante deslocamentos estratégicos. Essa função era essencial na organização e mobilidade dos grupos indígenas.");
	_last_item.image = spr_catalog_image;
	_last_item.type = CATALOG_ITEM_TYPE.KUNUMIUASU;
	
	_last_item = catalog_tabs[CATALOG_TAB.HISTORY].add_item(instance_create_layer(0, 0, LAYER_GUI_CATALOG_BUTTONS, obj_catalog_item));
	_last_item.label = "Muçurana";
	_last_item.set_text("Corda tecida com que se amarrava pela cintura o prisioneiro num sacrifício ritual. Os tupinambás do Rio de Janeiro a fabricavam de embira. Já os tupinambás da Bahia utilizavam algodão.");
	_last_item.image = spr_catalog_mucurana;
	_last_item.type = CATALOG_ITEM_TYPE.MUCURANA;
	
	catalog_tabs[CATALOG_TAB.HISTORY].set_selected(false);
	
	//// biodiversity items
	catalog_tabs[CATALOG_TAB.BIODIVERSITY] = instance_create_layer(catalog_tabs[CATALOG_TAB.HISTORY].bbox_left, catalog_tabs[CATALOG_TAB.REGIONS].y, LAYER_GUI_CATALOG_WINDOW, obj_catalog_tab);
	catalog_tabs[CATALOG_TAB.BIODIVERSITY].label = "Biodiversidade";
	_last_item = catalog_tabs[CATALOG_TAB.BIODIVERSITY].add_item(instance_create_layer(0, 0, LAYER_GUI_CATALOG_BUTTONS, obj_catalog_item));
	_last_item.label = "Arariboia";
	_last_item.set_text("Arariboia (Niterói, 1520-1589) foi um chefe do povo temiminó, pertencente à etnia tupi, que habitava o litoral brasileiro no século XVI. Ao ser batizado pelos jesuítas, recebeu o nome cristão de Martim Afonso de Sousa, em homenagem ao donatário da Capitania de São Vicente, Martim Afonso de Sousa.\n"
		+ "Ficou conhecido na história devido à sua aliança com os portugueses, fundamental para a conquista da baía de Guanabara frente aos tamoios e franceses, em 1567.\n"
		+ "Como recompensa, recebeu da coroa portuguesa a propriedade de terras localizadas na entrada da baía de Guanabara.\n"
		+ "Ali foi estabelecida a aldeia de São Lourenço, que futuramente daria origem à cidade de Niterói, da qual é considerado o fundador.");
	_last_item.image = spr_catalog_arariboia;
	_last_item.type = CATALOG_ITEM_TYPE.ARARIBOIA;
	
	_last_item = catalog_tabs[CATALOG_TAB.BIODIVERSITY].add_item(instance_create_layer(0, 0, LAYER_GUI_CATALOG_BUTTONS, obj_catalog_item));
	_last_item.label = "Arara-canindé";
	_last_item.set_text("A arara-canindé (Ara ararauna) é uma ave impressionante, famosa por sua plumagem azul e amarela. Os tupinambás a adoravam, capturando-a viva para usar suas penas em rituais importantes, mas sem causar danos, soltando-a em seguida. Social e inteligente, essa arara tem um bico forte para quebrar sementes e desempenha um papel crucial na dispersão de sementes nas florestas tropicais.");
	_last_item.image = spr_catalog_caninde;
	_last_item.type = CATALOG_ITEM_TYPE.ARARA_CANINDE;
	
	_last_item = catalog_tabs[CATALOG_TAB.BIODIVERSITY].add_item(instance_create_layer(0, 0, LAYER_GUI_CATALOG_BUTTONS, obj_catalog_item));
	_last_item.label = "Armadeira";
	_last_item.set_text("A aranha-armadeira (Phoneutria) é considerada a mais venenosa do mundo, podendo atingir até 17 cm de comprimento. Conhecida por seu comportamento agressivo, é extremamente veloz e capaz de saltar até 40 cm. Quando ameaçada, adota uma postura defensiva característica,'se armando' ao levantar as patas dianteiras em posição de ataque.");
	_last_item.image = spr_catalog_armadeira;
	_last_item.type = CATALOG_ITEM_TYPE.ARMADEIRA;
	
	
	
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