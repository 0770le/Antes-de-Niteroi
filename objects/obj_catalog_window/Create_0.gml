enum CATALOG_TAB 
{
	BIODIVERSITY,
	HISTORY,
	REGIONS
}

x							= 480 * 1.5;
y							= 270 * 1.5;
image_xscale				= 1.9;
image_yscale				= 1.3;
is_open						= false;

catalog_tabs				= [];
catalog_items				= [];
selected_tab				= noone;
total_entries_text_color	= make_color_rgb(230, 230, 230);
total_entries_background	= spr_catalog_total;

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
	selected_tab.toggle_items(false);
	
	selected_tab.selected_item.clear_new();
	
	global.initializer.focus(noone);
	
	global.catalog_controller.hide_all();
	
	is_open = false;
}

function draw_second_background() 
{
	draw_sprite_ext(spr_catalog_window_3, 0, bbox_right - 10, y, 1.3, 1.18, 0, c_white, 1.0);
	
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
	draw_text(bbox_right - (sprite_get_width(_toggle_sprite)*_scale) - 80, bbox_bottom - 64, global.i18n.get_message("menu-catalog-controls-close"));
	draw_sprite_ext(_toggle_sprite, 0, bbox_right - 70, bbox_bottom - 65, _scale, _scale, 0, c_white, 1.0);
	
	draw_text(bbox_right - (sprite_get_width(_cancel_sprite)*_scale) - 190, bbox_bottom - 64, global.i18n.get_message("menu-catalog-controls-back"));
	draw_sprite_ext(_cancel_sprite, 0, bbox_right - 180, bbox_bottom - 65, _scale, _scale, 0, c_white, 1.0);
	
	// anterior e próxima aba
	var _tab_left_sprite = global.input_manager.get_menu_action_sprite(INPUT_MENU_ACTION.TAB_LEFT);
	var _tab_right_sprite = global.input_manager.get_menu_action_sprite(INPUT_MENU_ACTION.TAB_RIGHT);
	
	draw_text(bbox_right - (sprite_get_width(_tab_left_sprite)*_scale) - 440, bbox_bottom - 64, global.i18n.get_message("menu-catalog-controls-tab-previous"));
	draw_sprite_ext(_tab_left_sprite, 0, bbox_right - 430, bbox_bottom - 65, _scale, _scale, 0, c_white, 1.0);
	
	draw_text(bbox_right - (sprite_get_width(_tab_right_sprite)*_scale) - 290, bbox_bottom - 64, global.i18n.get_message("menu-catalog-controls-tab-next"));
	draw_sprite_ext(_tab_right_sprite, 0, bbox_right - 280, bbox_bottom - 65, _scale, _scale, 0, c_white, 1.0);
	
	// change language
	if (global.i18n.enable)
	{
		var _change_language_sprite = global.input_manager.get_menu_action_sprite(INPUT_MENU_ACTION.CHANGE_LANGUAGE);
		
		draw_text(bbox_right - (sprite_get_width(_change_language_sprite)*_scale) - 600, bbox_bottom - 64, global.i18n.get_message("menu-main-change-language"));
		draw_sprite_ext(_change_language_sprite, 0, bbox_right - 590, bbox_bottom - 65, _scale, _scale, 0, c_white, 1.0);
	}
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
	
	if (_input.toggle_catalog || _input.toggle_menu) {
		global.catalog_controller.close();
		
		return;
	}
	
	if (_input.cancel) 
	{
		global.catalog_controller.close();
		
		_input = new MenuInputModel();
		_input.toggle_menu = true;
		
		global.menu_controller.on_input_menu(_input);
		
		return;
	}
	
	if (_input.change_language && global.i18n.enable)
	{
		global.i18n.change_language(global.i18n.get_next_language());
		
		global.options_controller.set_option(global.i18n.language);
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
		
		if (_previous.label != selected_tab.label) 
		{
			global.sound_controller.play(FMOD_EVENT.MENU_GENERAL);
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
		
		if (_previous_index != _current_index) 
		{
			global.sound_controller.play(FMOD_EVENT.MENU_GENERAL);
		}
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

function draw_total_entries()
{
	draw_set_font(fnt_arial_medium_to_small);
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	draw_set_color(total_entries_text_color);
	
	var _background_x = bbox_right - 30;
	var _background_y = bbox_bottom;
	
	var _total_items = array_length(catalog_items);
	var _unlocked_items = array_length(
		array_filter(catalog_items, function (_item) { return !_item.locked })
	);
	
	var _text = global.i18n.get_message(
		"menu-catalog-total-unlocks", 
		{
			unlocked: string(_unlocked_items), 
			total: string(_total_items)
		}
	);
	
	draw_sprite(total_entries_background, 0, _background_x, _background_y);
	
	var _xx = sprite_get_width(total_entries_background) / 2;
	var _yy = sprite_get_height(total_entries_background) / 2;
	
	draw_text(_background_x - _xx, _background_y + _yy, _text);
}

function create_content()
{
	//tabs

#region //// regions items
	
	catalog_tabs[CATALOG_TAB.REGIONS] = instance_create_layer(bbox_right - 20, bbox_top + 10, LAYER_GUI_CATALOG_WINDOW, obj_catalog_tab);
	catalog_tabs[CATALOG_TAB.REGIONS].label	= "menu-catalog-tab-regions";
	var _last_item = catalog_tabs[CATALOG_TAB.REGIONS].add_item(instance_create_layer(0, 0, LAYER_GUI_CATALOG_BUTTONS, obj_catalog_item));
	_last_item.label = "Guajupiá";
	_last_item.set_text("Baía de Guanabara (RJ). Guajupiá, 'morada dos ancestrais', era para os tupinambás uma espécie de paraíso, onde descansavam os antepassados mais valorosos e memoráveis.\nAo chegarem à região, após descerem pelo litoral brasileiro e conquistarem territórios de outras tribos, passaram a chamá-la assim devido à sua abundância em frutos, peixes e recursos naturais.");
	_last_item.type = CATALOG_ITEM_TYPE.GUAJUPIA;
	
	_last_item = catalog_tabs[CATALOG_TAB.REGIONS].add_item(instance_create_layer(0, 0, LAYER_GUI_CATALOG_BUTTONS, obj_catalog_item));
	_last_item.label = "Cidade Velha";
	_last_item.set_text("Atual Praia de Fora (RJ). Situada entre a Pedra da Urca e a Cara de Cão, foi escolhida em 1567 como o ponto inicial de ocupação para a retomada da Baía dos Franceses.\nA topografia da região, com suas colinas e enseadas, oferecia um local ideal para a construção de fortificações.");
	_last_item.type = CATALOG_ITEM_TYPE.CIDADE_VELHA;
	
	_last_item = catalog_tabs[CATALOG_TAB.REGIONS].add_item(instance_create_layer(0, 0, LAYER_GUI_CATALOG_BUTTONS, obj_catalog_item));
	_last_item.label = "Nheteróia";
	_last_item.set_text("Para os tupinambás, o nome original do Rio de Janeiro seria Niterói.\nHá indícios de que esse nome também serviria para designar toda a costa da baía e uma aldeia na margem direita da mesma.\nSua etimologia pode significar tanto 'costa toda sinuosa' quanto 'rio escondido'.");
	_last_item.type = CATALOG_ITEM_TYPE.NHETEROIA;	
	
	_last_item = catalog_tabs[CATALOG_TAB.REGIONS].add_item(instance_create_layer(0, 0, LAYER_GUI_CATALOG_BUTTONS, obj_catalog_item));
	_last_item.label = "Keriy";
	_last_item.set_text("Atual Saco de São Francisco, Niterói (RJ). O nome dessa taba é referência as ostras que se reproduziam nas águas idealmente calmas desse vale.\nAinda nos dias de hoje a região produz ostras como atividade econômica." );
	_last_item.type = CATALOG_ITEM_TYPE.KERIY;	
	
	_last_item = catalog_tabs[CATALOG_TAB.REGIONS].add_item(instance_create_layer(0, 0, LAYER_GUI_CATALOG_BUTTONS, obj_catalog_item));
	_last_item.label = "Akaray";
	_last_item.set_text("Atual bairro de Icaraí, Niterói (RJ). A região formava um enorme areal com vegetação típica de restinga, pitangueiras, cajueiros e cactos.\nSeu nome deriva do peixe de água doce acará ou cará, significando algo como 'Rio dos Acarás'.");
	_last_item.type = CATALOG_ITEM_TYPE.AKARAY;	
	
	_last_item = catalog_tabs[CATALOG_TAB.REGIONS].add_item(instance_create_layer(0, 0, LAYER_GUI_CATALOG_BUTTONS, obj_catalog_item));
	_last_item.label = "Morgujá-uausú";
	_last_item.set_text("Atual Centro de Niterói (RJ). A taba de nome 'Maracujá Grande' se devia ao fato da região ter apresentado grande fartura da fruta cítrica e doce que curava o escorbuto dos marinheiros recém chegados das longas viagens pelo oceano.");
	_last_item.type = CATALOG_ITEM_TYPE.MORGUJA_UASU;	
	
	_last_item = catalog_tabs[CATALOG_TAB.REGIONS].add_item(instance_create_layer(0, 0, LAYER_GUI_CATALOG_BUTTONS, obj_catalog_item));
	_last_item.label = "Kurumuré";
	_last_item.set_text("Atual área entre o rio Maruí e o bairro de Neves, Niterói(RJ). A 'taba das Taínhas' atestava a grande importancia desse peixe para a comunidade tupinambá.\nEles as pescavam usando flechas e usavam sua carne para preparar uma 'farinha de guerra' altamente durável e nutritiva, que servia como sustento aos guerreiros durante missões em busca de inimigos distantes." );
	_last_item.type = CATALOG_ITEM_TYPE.KURUMURE;
	
	_last_item = catalog_tabs[CATALOG_TAB.REGIONS].add_item(instance_create_layer(0, 0, LAYER_GUI_CATALOG_BUTTONS, obj_catalog_item));
	_last_item.label = "Itaóka";
	_last_item.set_text("Atual bairro de Itaoca, São Gonçado (RJ). A aldeia da 'Casa de Pedra' provavelmente levou esse nome devio à referência alguma pedra grande ou ao fato de que suas malocas estariam encostadas em relevos de granito.\nO litoral de Itaóka era chamado de Suaçuna, referência ao sûasu, cervo para os tupinambás." );
	_last_item.type = CATALOG_ITEM_TYPE.ITAOKA;
	
	_last_item = catalog_tabs[CATALOG_TAB.REGIONS].add_item(instance_create_layer(0, 0, LAYER_GUI_CATALOG_BUTTONS, obj_catalog_item));
	_last_item.label = "Itaóka - Último Bastião";
	_last_item.set_text("A terceira e última fortaleza dos tamoios na baía de Guanabara. Foi para a costa de suaçuna, área conhecida como 'porto dos franceses', que franceses e tupinambas recuaram após a derrota na batalha de Paranapucu.\nNa aldeia de Itaóka se erguia três cercas fortissímas com muitos baluartes e casas fortes. Essa fortaleza servia estrategicamente para guardar uma rota de retirada para a reorganização dos efetivos nativos no Cabo Frio." );
	_last_item.type = CATALOG_ITEM_TYPE.ITAOKA_FORT;
	
	_last_item = catalog_tabs[CATALOG_TAB.REGIONS].add_item(instance_create_layer(0, 0, LAYER_GUI_CATALOG_BUTTONS, obj_catalog_item));
	_last_item.label = "Ilha de Serigipe";
	_last_item.set_text("Atual Ilha de Villegagnon (RJ), anexada ao Aeroporto Santos Dumont. Na Ilha de Serigipe ficava localizado o Forte Coligny, centro do assentamento colonial francês chamado França Antártica (1555-1560), liderado por Nicolas Durand de Villegagnon (1510-1571). " );
	_last_item.type = CATALOG_ITEM_TYPE.SEREGIPE;
	
	_last_item = catalog_tabs[CATALOG_TAB.REGIONS].add_item(instance_create_layer(0, 0, LAYER_GUI_CATALOG_BUTTONS, obj_catalog_item));
	_last_item.label = "Karióca";
	_last_item.set_text("Atualmente o que conhecemos como Flamengo, Laranjeiras, Largo do Machado, Catete e Glória (RJ). O rio carioca herdou o nome da taba: 'casa dos (indígenas) cariós'. Os cariós eram uma tribo rival que compartilhava língua e costumes com tupinambas.\nEm Karióca, viviam cativos até que se realizassem os rituais antropofágicos. Era uma comunidade tupi enorme com muitas malocas e foi a comunidade que mais interagiu e auxiliou os franceses do forte Coligny." );
	_last_item.type = CATALOG_ITEM_TYPE.KARIOCA;
	
	_last_item = catalog_tabs[CATALOG_TAB.REGIONS].add_item(instance_create_layer(0, 0, LAYER_GUI_CATALOG_BUTTONS, obj_catalog_item));
	_last_item.label = "Karióca - Reri'pê";
	_last_item.set_text("Alto do atual Morro da Glória (RJ). Com o apoio e a orientação de alguns franceses, os tupinambás construíram uma grande cerca de madeira, equipada com torres para armas de fogo, além de possuírem diversas espingardas.\nNa praia, haviam cavado fossos armados com estrepes como armadilhas. Chamado pelos nativos de rery-pê, lugar das ostras, ali se encontrava a primeira fortaleza tupinambá enfrentada pelos temiminós e portugueses na grande batalha de Uruçumirim.\nDurante essa batalha, Estácio de Sá, mesmo usando sua armadura completa, foi mortalmente ferido por uma flecha inimiga." );
	_last_item.type = CATALOG_ITEM_TYPE.RERI_PE;
	
	_last_item = catalog_tabs[CATALOG_TAB.REGIONS].add_item(instance_create_layer(0, 0, LAYER_GUI_CATALOG_BUTTONS, obj_catalog_item));
	_last_item.label = "Gûyragûasu'unaê";
	_last_item.set_text("Atual Centro da cidade do Rio de Janeiro (RJ). Gûyragûasu’unaê é a Harpia, 'o grande passaro negro'. Nome do seu lider, e por extensão sua aldeia, é como chamavam uma ave de rapina gigantesca que habitava a Guanabara." );
	_last_item.type = CATALOG_ITEM_TYPE.GUYRAGUASU_UNAE;
	
	_last_item = catalog_tabs[CATALOG_TAB.REGIONS].add_item(instance_create_layer(0, 0, LAYER_GUI_CATALOG_BUTTONS, obj_catalog_item));
	_last_item.label = "Jabebiracica";
	_last_item.set_text("Atual Rio Comprido e São Cristovão (RJ).  A taba da 'Arraia Cortada', possivelmente se referenciando ao peixe-viola.\nEstava em posição estratégica pois por ela passavam diversas rotas indígenas." );
	_last_item.type = CATALOG_ITEM_TYPE.JABEBIRACICA;
	
	_last_item = catalog_tabs[CATALOG_TAB.REGIONS].add_item(instance_create_layer(0, 0, LAYER_GUI_CATALOG_BUTTONS, obj_catalog_item));
	_last_item.label = "Paranãpuã";
	_last_item.set_text("Atual Ilha do Governador (RJ). Seu nome se traduz por 'Ilha do Mar'. Era um local priveligiado dentro da Guanabara pela fartura em água doce e por seus mares calmos, por isso era um território disputado apesar de ser conhecidamente território de onças.\nEra conhecida como 'Ilha do gato' pois era ocupada pelos marakaîás, 'gatos-do-mato', na época que os portugueses chegaram pela primeira vez na baía. Era a tribo a qual pertencia Arariboia e de identificariam como Temiminós. O território foi tomado pelos Tamoios que lá ergueram uma fortaleza." );
	_last_item.type = CATALOG_ITEM_TYPE.PARANAPUA;
	
	_last_item = catalog_tabs[CATALOG_TAB.REGIONS].add_item(instance_create_layer(0, 0, LAYER_GUI_CATALOG_BUTTONS, obj_catalog_item));
	_last_item.label = "Paranãpuã - Paranacupu";
	_last_item.set_text("O assalto a fortaleza localizada na taba de Paranacupu,'Mar Comprido', durou três dias e envolveu milhares de guerreiros e muita artilharia.\nLá, foi construida uma fortaleza dos tamoios ainda maior que a de Reri-pê. Quando foi tomada por temiminós e portugueses, os indígenas recuaram para Itaóka." );
	_last_item.type = CATALOG_ITEM_TYPE.PARANACUPU;

#endregion	
	
	catalog_tabs[CATALOG_TAB.REGIONS].set_selected(false);
	
#region //// history items
	catalog_tabs[CATALOG_TAB.HISTORY] = instance_create_layer(catalog_tabs[CATALOG_TAB.REGIONS].bbox_left, catalog_tabs[CATALOG_TAB.REGIONS].y, LAYER_GUI_CATALOG_WINDOW, obj_catalog_tab);
	catalog_tabs[CATALOG_TAB.HISTORY].label	= "menu-catalog-tab-history";
	_last_item = catalog_tabs[CATALOG_TAB.HISTORY].add_item(instance_create_layer(0, 0, LAYER_GUI_CATALOG_BUTTONS, obj_catalog_item));
	_last_item.label = "Tupinambá";
	_last_item.set_text("Os Tupinambás eram um povo indígena do grupo tupi-guarani que habitava principalmente o litoral brasileiro. Eles tinham uma sociedade complexa, organizada em tribos e aldeias, com uma hierarquia bem definida entre as lideranças.\n A agricultura era baseada principalmente no cultivo de mandioca, milho e batata-doce, com técnicas de roça. Os guerreiros se pintavam e se ornavam com as penas vermelhas do guará. \nOs Tupinambás praticavam a antropofagia em contexto ritualístico e simbólico, especialmente como parte de guerras intertribais. O ato representava a incorporação da força e bravura do inimigo, sendo um elemento cultural ligado à espiritualidade e crenças desse povo.");
	_last_item.type = CATALOG_ITEM_TYPE.TUPINAMBA;
	
	_last_item = catalog_tabs[CATALOG_TAB.HISTORY].add_item(instance_create_layer(0, 0, LAYER_GUI_CATALOG_BUTTONS, obj_catalog_item));
	_last_item.label = "Morubixaba";
	_last_item.set_text("Título conferido ao grande chefe, o 'principal' de uma taba.\nEsse posto era reservado a indígenas com mais de 40 anos, que haviam acumulado vasta experiência em batalhas e conquistado prestígio por seus feitos em combate.\nEram líderes de expedições militares e participavam de conselhos que ocorriam entre os líderes das Tabas.");
	_last_item.type = CATALOG_ITEM_TYPE.MORUBIXABA;
	
	_last_item = catalog_tabs[CATALOG_TAB.HISTORY].add_item(instance_create_layer(0, 0, LAYER_GUI_CATALOG_BUTTONS, obj_catalog_item));
	_last_item.label = "Araryboîa";
	_last_item.set_text("Arariboia (Niterói, 1520-1589) foi chefe do povo temiminó, pertencente à etnia tupi. Ao ser batizado pelos jesuítas, recebeu o nome cristão de Martim Afonso de Sousa.\n" 
		+ "Ficou conhecido na história devido à sua aliança com os portugueses, fundamental para a conquista da baía de Guanabara frente aos tamoios e franceses, em 1567.\n"
		+ "Recebeu da coroa portuguesa a propriedade de terras localizadas na entrada da baía de Guanabara e estabeleceu ali a aldeia de São Lourenço, que futuramente daria origem à cidade de Niterói, da qual é considerado o fundador."); 
	_last_item.type = CATALOG_ITEM_TYPE.ARARYBOIA;
	
	_last_item = catalog_tabs[CATALOG_TAB.HISTORY].add_item(instance_create_layer(0, 0, LAYER_GUI_CATALOG_BUTTONS, obj_catalog_item));
	_last_item.label = "Kunumĩuasu";
	_last_item.set_text("Palavra de origem tupi-guarani que significa 'grande menino' ou 'grande jovem'. 'Kunumĩ' refere-se a menino, jovem ou rapaz, enquanto 'uasu' (ou 'guasu') significa grande.\nAlém disso, também designa uma posição militar iniciante, atribuída a jovens guerreiros responsáveis por remar as canoas durante deslocamentos estratégicos. Essa função era essencial na organização e mobilidade dos grupos indígenas.");
	_last_item.type = CATALOG_ITEM_TYPE.KUNUMIUASU;
	
	_last_item = catalog_tabs[CATALOG_TAB.HISTORY].add_item(instance_create_layer(0, 0, LAYER_GUI_CATALOG_BUTTONS, obj_catalog_item));
	_last_item.label = "Taba";
	_last_item.set_text("A taba era uma aldeia típica dos tupinambás. As tabas eram organizadas de forma circular ou oval, com as malocas dispostas ao redor de uma área central, onde ocorriam rituais, reuniões e atividades comunitárias.\nEssa organização favorecia a segurança e a interação social. Cada uma tinha seus domínios territoriais. Elas recebiam o mesmo nome que seu Principal escolheu para si, frequentemente valorizando algo marcante da natureza ao seu redor.");
	_last_item.type = CATALOG_ITEM_TYPE.TABA;
	
	_last_item = catalog_tabs[CATALOG_TAB.HISTORY].add_item(instance_create_layer(0, 0, LAYER_GUI_CATALOG_BUTTONS, obj_catalog_item));
	_last_item.label = "Maloca";
	_last_item.set_text("As malocas eram grandes habitações coletivas típicas de diversos povos indígenas do Brasil, incluindo os tupinambás.\nConstruídas com madeira, cipó e palha, abrigavam várias famílias de uma mesma comunidade");
	_last_item.type = CATALOG_ITEM_TYPE.MALOCA;
	
	_last_item = catalog_tabs[CATALOG_TAB.HISTORY].add_item(instance_create_layer(0, 0, LAYER_GUI_CATALOG_BUTTONS, obj_catalog_item));
	_last_item.label = "Tamoios";
	_last_item.set_text("Se identificavam como 'Os avós' ou 'os mais velhos' da terra. a Confederação dos Tamoios(1554-1567) foi a confederação indígena formada principalmente por grupos tupinambás que habitavam o litoral do sudeste do Brasil. \nEles se uniram para resistir à colonização portuguesa e contavam com o apoio de franceses, que disputavam território com os portugueses .");
	_last_item.type = CATALOG_ITEM_TYPE.TAMOIOS;
	
	_last_item = catalog_tabs[CATALOG_TAB.HISTORY].add_item(instance_create_layer(0, 0, LAYER_GUI_CATALOG_BUTTONS, obj_catalog_item));
	_last_item.label = "Temininós";
	_last_item.set_text("O termo (t)emiminõ também podia ser usado para neto ou tupiminó, que queria dizer tupi + emiminõ, ou seja, os descendentes dos tupis.\nAssim eram chamados os inimigos dos tamoios, a tribo dos maracajás (gato-do-mato). Liderados por Marakaîágûaçu, 'o grande gato', foram expulsos pelos tupinambás de seu território na ilha do Governador e se aliaram aos portugueses. Arariboia se tornou líder dos temiminós e participou da 'grande guerra'.");
	_last_item.type = CATALOG_ITEM_TYPE.TEMININOS;
	
	_last_item = catalog_tabs[CATALOG_TAB.HISTORY].add_item(instance_create_layer(0, 0, LAYER_GUI_CATALOG_BUTTONS, obj_catalog_item));
	_last_item.label = "Marãna-uasú";
	_last_item.set_text("A 'grande guerra'. Faz referência aos conflitos pelo controle do sudeste brasileiro. Os tamoios e os franceses combateram temiminós e portugueses. Depois da destruição do forte francês Coligny, ainda ocorreram três grandes batalhas para tomar fortalezas tupinambás.\nOs tamoios tinham um plano elaborado e asseguravam pontos importantes para o controle da baía. A primeira era a fortaleza de Uruçumirim, próxima à taba Karióca. A segunda era Parnacupu, na ilha do governador. O último ponto de defesa foi a fortaleza da taba de Itaoka, litoral de São Gonçalo. De lá, recuaram para a região de Cabo Frio. A baía de Guanabara foi conquistada pelos Temiminós e seus aliados portugueses.");
	_last_item.type = CATALOG_ITEM_TYPE.MARANA_UASU;
	
	_last_item = catalog_tabs[CATALOG_TAB.HISTORY].add_item(instance_create_layer(0, 0, LAYER_GUI_CATALOG_BUTTONS, obj_catalog_item));
	_last_item.label = "Truchement";
	_last_item.set_text("Palavra francesa que significa 'intermediário' ou 'representante'. Franceses que eram deixados com os indígenas, muitos sendo jovens, para aprender a língua com o objetivo de fazer negócios posteriormente. Eles adotaram completamente os costumes dos tupinambás, costituindo família e participando de todos os costumes e rituais. \nServiam como tradutores para os franceses, mas, quando tinham de escolher, optavam por se rebelar contra os europeus em vez de trair ou abandonar sua taba e seus costumes");
	_last_item.type = CATALOG_ITEM_TYPE.TRUCHEMENT;
	
	_last_item = catalog_tabs[CATALOG_TAB.HISTORY].add_item(instance_create_layer(0, 0, LAYER_GUI_CATALOG_BUTTONS, obj_catalog_item));
	_last_item.label = "Cristãos";
	_last_item.set_text("Os dois religiosos mais respeitados pelos indígenas. Manuel da Nóbrega e José de Anchieta foram jesuítas que tiveram papel crucial na catequização indígena e na colonização do Brasil.\nNóbrega foi líder da missão jesuíta e atuou na fundação de São Paulo. Anchieta destacou-se como educador e escritor.");
	_last_item.type = CATALOG_ITEM_TYPE.CRISTAOS;
	
	_last_item = catalog_tabs[CATALOG_TAB.HISTORY].add_item(instance_create_layer(0, 0, LAYER_GUI_CATALOG_BUTTONS, obj_catalog_item));
	_last_item.label = "Ibirapema";
	_last_item.set_text("Tipo de tacape usado pelos povos indígenas, especialmente os Tupinambás. Pesado e feito de madeira muito dura, seu impacto podia matar um homem com apenas um golpe na cabeça.\nEra utilizada em combates e também em rituais, incluindo práticas ligadas à antropofagia cerimonial e era adornados com penas.");
	_last_item.type = CATALOG_ITEM_TYPE.IBIRAPEMA;
	
	_last_item = catalog_tabs[CATALOG_TAB.HISTORY].add_item(instance_create_layer(0, 0, LAYER_GUI_CATALOG_BUTTONS, obj_catalog_item));
	_last_item.label = "Urapaçã";
	_last_item.set_text("O conjunto arco e flecha era a arma preferencial dos tupinambás. Desde recém nascidos recebiam uma versão diminuta do ibirapema e do arco com flechas, além das garras e dentes dos animais mais perigosos como brinquedos.\nÀ medida que cresciam, suas armas o acompanhavam. Eles se tornavam tão bons arqueiros que conseguiam acertar peixes em baixo d'água, pássaros em voo e até as finas viseiras dos elmos das armaduras europeias.");
	_last_item.type = CATALOG_ITEM_TYPE.URAPACA;

	_last_item = catalog_tabs[CATALOG_TAB.HISTORY].add_item(instance_create_layer(0, 0, LAYER_GUI_CATALOG_BUTTONS, obj_catalog_item));
	_last_item.label = "Assojaba";
	_last_item.set_text("Os mantos Tupinambá, conhecidos como assojaba, eram vestimentas sagradas de grande importância espiritual e simbólica para os Tupinambás. Confeccionados com penas de aves nativas, principalmente do guará (de cor vermelha intensa), fixadas em uma trama de fibras naturais através de técnicas ancestrais de costura, esses mantos eram utilizados em ocasiões formais e rituais significativos, como assembleias, enterros e as cerimônias antropofágicas, que eram as mais solenes.O ato de vestir o manto representava uma profunda conexão com os ancestrais e o mundo espiritual, sendo um símbolo de poder, liderança e prestígio.");
	_last_item.type = CATALOG_ITEM_TYPE.ASSOJABA;
	
	_last_item = catalog_tabs[CATALOG_TAB.HISTORY].add_item(instance_create_layer(0, 0, LAYER_GUI_CATALOG_BUTTONS, obj_catalog_item));
	_last_item.label = "Muçurana";
	_last_item.set_text("Corda tecida com que se amarrava pela cintura o prisioneiro num sacrifício ritual.\nOs tupinambás do Rio de Janeiro a fabricavam de embira. Já os tupinambás da Bahia utilizavam algodão.");
	_last_item.type = CATALOG_ITEM_TYPE.MUCURANA;
	
	_last_item = catalog_tabs[CATALOG_TAB.HISTORY].add_item(instance_create_layer(0, 0, LAYER_GUI_CATALOG_BUTTONS, obj_catalog_item));
	_last_item.label = "Tráfico";
	_last_item.set_text("Por volta de 1500, com a chegada dos portugueses ao Brasil, iniciou-se uma exploração dos recursos naturais que incluía o comércio de peles de animais e aves nativas. Embora o foco inicial fosse o pau-brasil, o fascínio europeu pela fauna exótica do Novo Mundo logo impulsionou a busca por outros produtos. Peles de animais como onças, araras e outros mamíferos e aves coloridas eram apreciadas na Europa como itens de curiosidade, decoração e vestuário. Os indígenas, que possuíam profundo conhecimento da fauna local e técnicas de caça, frequentemente eram envolvidos nesse comércio, seja por escambo ou sob coerção. Esse tráfico inicial, embora em menor escala que a exploração de madeira, já representava uma pressão sobre as populações de animais e aves da Mata Atlântica e de outros biomas brasileiros.");
	_last_item.type = CATALOG_ITEM_TYPE.TRAFICO;
	
#endregion
	
	catalog_tabs[CATALOG_TAB.HISTORY].set_selected(false);
	
#region //// biodiversity items
	catalog_tabs[CATALOG_TAB.BIODIVERSITY] = instance_create_layer(catalog_tabs[CATALOG_TAB.HISTORY].bbox_left, catalog_tabs[CATALOG_TAB.REGIONS].y, LAYER_GUI_CATALOG_WINDOW, obj_catalog_tab);
	catalog_tabs[CATALOG_TAB.BIODIVERSITY].label = "menu-catalog-tab-biodiversity";
	_last_item = catalog_tabs[CATALOG_TAB.BIODIVERSITY].add_item(instance_create_layer(0, 0, LAYER_GUI_CATALOG_BUTTONS, obj_catalog_item));
	_last_item.label = "Cobra-Arara";
	_last_item.set_text("A cobra-papagaio (Corallus caninus), também chamada de periquitamboia ou jiboia-esmeralda, recebe o nome tupi 'araramboia'(cobra arara) devido à sua coloração verde vibrante. \nEssa serpente arborícola, que pode atingir dois metros, possui a mordida mais dolorosa entre cobras não peçonhentas, devido a suas presas grandes e fileiras de dentes afiados e curvados. Frequentemente em galhos altos, seus botes podiam atingir o rosto ou pescoço. Sua especialidade em emboscadas pode ter inspirado a escolha o nome do líder Temiminó, Arariboia.");
	_last_item.type = CATALOG_ITEM_TYPE.COBRA_ARARA;
	
	_last_item = catalog_tabs[CATALOG_TAB.BIODIVERSITY].add_item(instance_create_layer(0, 0, LAYER_GUI_CATALOG_BUTTONS, obj_catalog_item));
	_last_item.label = "Maracajá";
	_last_item.set_text("O maracajá (Leopardus wiedii), ou gato-do-mato-pequeno, é um felino de 3 a 5 kg encontrado na América Latina, incluindo o Brasil. Com corpo de até 80 cm e cauda longa, é noturno, arborícola e ágil, capaz de girar os tornozelos em 180° para descer árvores de cabeça para baixo. Sua pelagem manchada o camufla na mata. Alimenta-se de pequenos animais e sofre com a perda de habitat e a caça ilegal.");
	_last_item.type = CATALOG_ITEM_TYPE.MARACAJA;
	
	_last_item = catalog_tabs[CATALOG_TAB.BIODIVERSITY].add_item(instance_create_layer(0, 0, LAYER_GUI_CATALOG_BUTTONS, obj_catalog_item));
	_last_item.label = "Arara-canindé";
	_last_item.set_text("A arara-canindé (Ara ararauna) é uma ave impressionante, famosa por sua plumagem azul e amarela. Os tupinambás a adoravam, capturando-a viva para usar suas penas em rituais importantes, mas sem causar danos, soltando-a em seguida. Social e inteligente, essa arara tem um bico forte para quebrar sementes e desempenha um papel crucial na dispersão de sementes nas florestas tropicais.");
	_last_item.type = CATALOG_ITEM_TYPE.ARARA_CANINDE;
	
	_last_item = catalog_tabs[CATALOG_TAB.BIODIVERSITY].add_item(instance_create_layer(0, 0, LAYER_GUI_CATALOG_BUTTONS, obj_catalog_item));
	_last_item.label = "Arara-azul";
	_last_item.set_text("A arara-azul (Anodorhynchus hyacinthinus) é a maior espécie de arara, podendo atingir até 1 metro de comprimento e pesar cerca de 1,5 kg. Com penas de um azul vibrante e manchas amarelas ao redor dos olhos e na base do bico, destaca-se pela beleza e inteligência. A arara-azul não está extinta no estado do Rio de Janeiro, mas suas populações são extremamente raras na região. Essa espécie é mais comum no Pantanal e em algumas áreas da Amazônia. No Rio de Janeiro, avistamentos são incomuns e geralmente associados a indivíduos mantidos em cativeiro ou a projetos de reintrodução. A perda de habitat e o tráfico de animais são as principais ameaças à espécie.");
	_last_item.type = CATALOG_ITEM_TYPE.ARARA_AZUL;
	
	_last_item = catalog_tabs[CATALOG_TAB.BIODIVERSITY].add_item(instance_create_layer(0, 0, LAYER_GUI_CATALOG_BUTTONS, obj_catalog_item));
	_last_item.label = "Arara-vermelha";
	_last_item.set_text("A arara-vermelha (Ara chloropterus) é uma ave de plumagem vibrante, predominantemente vermelha, com detalhes verdes e azuis nas asas. Pode atingir até 90 cm de comprimento e pesar cerca de 1,5 kg. É conhecida por sua inteligência e forte vínculo social. No Rio de Janeiro, é encontrada principalmente em áreas de Mata Atlântica preservada, embora sua população esteja reduzida devido ao desmatamento e ao tráfico de animais silvestres.");
	_last_item.type = CATALOG_ITEM_TYPE.ARARA_VERMELHA;
	
	_last_item = catalog_tabs[CATALOG_TAB.BIODIVERSITY].add_item(instance_create_layer(0, 0, LAYER_GUI_CATALOG_BUTTONS, obj_catalog_item));
	_last_item.label = "Guará";
	_last_item.set_text("O guará (Eudocimus ruber) é uma ave de plumagem vermelho-vivo, resultado de sua alimentação rica em carotenoides. Possui pernas e bicos longos, sendo o bico curvo. Pode atingir até 60 cm de comprimento e é conhecido por formar grandes bandos. No Brasil, é encontrado principalmente em manguezais e áreas costeiras, incluindo o estado do Rio de Janeiro, onde sua presença indica a boa saúde ambiental desses ecossistemas.");
	_last_item.type = CATALOG_ITEM_TYPE.GUARA;
	
	_last_item = catalog_tabs[CATALOG_TAB.BIODIVERSITY].add_item(instance_create_layer(0, 0, LAYER_GUI_CATALOG_BUTTONS, obj_catalog_item));
	_last_item.label = "Armadeira";
	_last_item.set_text("A aranha-armadeira (Phoneutria) é considerada a aranha mais venenosa do mundo. Seu veneno é neurotóxico e pode causar sintomas como dor intensa, suor excessivo, taquicardia, aumento da pressão arterial e, em casos mais graves, choque e edema pulmonar.  Podendo atingir até 17 cm de comprimento, é conhecida por seu comportamento agressivo. É extremamente veloz e capaz de saltar até 40 cm. Quando ameaçada, adota uma postura defensiva característica,'se armando' ao levantar as patas dianteiras em posição de ataque.");
	_last_item.type = CATALOG_ITEM_TYPE.ARMADEIRA;
	
	_last_item = catalog_tabs[CATALOG_TAB.BIODIVERSITY].add_item(instance_create_layer(0, 0, LAYER_GUI_CATALOG_BUTTONS, obj_catalog_item));
	_last_item.label = "Jararaca";
	_last_item.set_text("A jararaca (Bothrops jararaca) é uma serpente venenosa encontrada principalmente no Brasil, especialmente na Mata Atlântica. Pode atingir até 1,6 metro de comprimento e apresenta corpo robusto com coloração que varia entre tons de marrom e cinza, com padrões que favorecem a camuflagem. Por ser um animal agressivo é responsável por grande parte dos acidentes ofídicos no país, e seu veneno pode causar dor intensa, inchaço e, em casos graves, necrose tecidual.");
	_last_item.type = CATALOG_ITEM_TYPE.JARARACA;
	
	_last_item = catalog_tabs[CATALOG_TAB.BIODIVERSITY].add_item(instance_create_layer(0, 0, LAYER_GUI_CATALOG_BUTTONS, obj_catalog_item));
	_last_item.label = "Onça-pintada";
	_last_item.set_text("Îagûara, a onça-pintada(Panthera onca) é capaz de abater presas maiores que ela. Emprega diversas técnicas de caça como emboscadas silenciosas, perseguições rápidas e mesmo a natação. Sua pelagem oferece excelente camuflagem na vegetação densa .\nSua mordida é a mais potente de todos os felinos em relação ao tamanho da cabeça, capaz de perfurar cascos de tartarugas e couro de jacarés com facilidade. Essa força permite que a onça mate suas presas com uma única mordida, frequentemente direcionada para partir o crânio ou pescoço.\n Há registros de onças pesando até cento e sessenta kilos, com dois metros e meio do comprimento(excluindo cauda) e quase um metro de altura do chão até o topo de seu dorso (excluindo pescoço e cabeça). As onças dominavam a baía de guanabara e não era raro que uma pessoa fosse devorada por uma. \nOs tupinambás presenteavam seus recém nascidos com suas presas.");	
	_last_item.type = CATALOG_ITEM_TYPE.IAGUARA;
	
	_last_item = catalog_tabs[CATALOG_TAB.BIODIVERSITY].add_item(instance_create_layer(0, 0, LAYER_GUI_CATALOG_BUTTONS, obj_catalog_item));
	_last_item.label = "Harpia";
	_last_item.set_text("A Gûyragûasu'unaê, Harpia harpyja, embora não seja a maior, é a mais pesada e possui a maior força entre todas as águias, fazendo dela a mais poderosa das aves de rapina. Suas garras podem ter até treze centímetros, sendo maiores que as garras de um urso pardo. Pesando até nove kilos, com um metro de altura e dois de envergadura, abatende preguiças, macacos, tamanduás e até filhotes de veado. \n Habitando as florestas tropicais da América Central e do Sul, incluindo a Amazônia brasileira, caça no interior da mata fechada com voo silencioso e extremamente ágil. O céu da Mata Atlântica da baía de Guanabara quinhentista foi território desses animais fantásticos. \nOs tupinambás presenteavam seus recém nascidos com suas garras.");	
	_last_item.type = CATALOG_ITEM_TYPE.HARPIA;
	
	_last_item = catalog_tabs[CATALOG_TAB.BIODIVERSITY].add_item(instance_create_layer(0, 0, LAYER_GUI_CATALOG_BUTTONS, obj_catalog_item));
	_last_item.label = "Urucum e Jenipapo";
	_last_item.set_text("O urucum (Bixa orellana) e o jenipapo (Genipa americana) são plantas nativas importantes para os tupinambás.\nO urucum, com suas sementes vermelhas, era amplamente utilizado para a pintura corporal, tingindo a pele em rituais de guerra e celebrações. Essa pintura possuía significados culturais profundos, identificando guerreiros e marcando momentos importantes. \nJá o genipapo, com seus frutos que produzem um suco escuro, era usado para pinturas corporais de cor preta ou azul escura, também com funções rituais e sociais. \nA combinação dessas tinturas permitia aos tupinambás criar uma rica variedade de padrões geométricos e representações simbólicas em seus corpos, expressando sua identidade, status social e participação em rituais.");
	_last_item.type = CATALOG_ITEM_TYPE.URUCUM_GENIPAPO;
	
	_last_item = catalog_tabs[CATALOG_TAB.BIODIVERSITY].add_item(instance_create_layer(0, 0, LAYER_GUI_CATALOG_BUTTONS, obj_catalog_item));
	_last_item.label = "Pau-brasil";
	_last_item.set_text("O pau-brasil (Paubrasilia echinata) foi uma das primeiras riquezas naturais do Brasil a despertar o interesse dos colonizadores portugueses, por volta de 1500, incluindo a região que hoje conhecemos como o estado do Rio de Janeiro. \nEssa árvore nativa da Mata Atlântica, com seu tronco de cor vermelha intensa, como brasa (origem do nome do país), rendia um corante de alta qualidade muito valorizado na Europa para tingir tecidos de luxo. A exploração do pau-brasil no Rio de Janeiro e em outras áreas do litoral foi intensa e predatória desde os primeiros anos da colonização.\nOs portugueses estabeleceram um sistema de escambo com os indígenas, trocando ferramentas e armas de metal por toras da madeira. Essa exploração inicial teve um impacto significativo na flora local e nas relações entre colonizadores e povos originários.");
	_last_item.type = CATALOG_ITEM_TYPE.PAU_BRASIL;
	
	_last_item = catalog_tabs[CATALOG_TAB.BIODIVERSITY].add_item(instance_create_layer(0, 0, LAYER_GUI_CATALOG_BUTTONS, obj_catalog_item));
	_last_item.label = "Bromélias";
	_last_item.set_text("A Mata Atlântica tem muitas bromélias diferentes (família Bromeliaceae). Essas plantas, que vivem em cima de outras árvores sem machucá-las (são epífitas), são encontradas por toda a floresta, presas nos troncos e nos galhos.\nAs bromélias da região têm vários formatos, cores e tamanhos. Suas folhas formam pequenos depósitos de água da chuva. Essa água é muito importante para bichinhos pequenos, como larvas de mosquitos, sapinhos coloridos e pequenos crustáceos, criando uma cadeia alimentar dentro da floresta. A grande quantidade de bromélias ajuda a manter a umidade e a variedade de vida na Mata Atlântica, influenciando muitos outros animais e plantas.");
	_last_item.type = CATALOG_ITEM_TYPE.BROMELIAS;
	
	_last_item = catalog_tabs[CATALOG_TAB.BIODIVERSITY].add_item(instance_create_layer(0, 0, LAYER_GUI_CATALOG_BUTTONS, obj_catalog_item));
	_last_item.label = "Orquídeas";
	_last_item.set_text( "A Mata Atlântica tem muitas orquídeas diferentes (família Orchidaceae). Essas plantas, conhecidas por suas flores bonitas e variadas, são encontradas em diversos lugares da floresta, muitas vezes vivendo em cima de árvores (são epífitas).\nAs orquídeas da região apresentam uma grande diversidade de formas, cores e tamanhos de flores. Algumas têm flores grandes e chamativas, enquanto outras possuem flores pequenas e delicadas. As orquídeas dependem de insetos e outros animais para levar o pólen de uma flor para outra, garantindo a produção de sementes.");
	_last_item.type = CATALOG_ITEM_TYPE.ORQUIDEAS;
	
	catalog_tabs[CATALOG_TAB.BIODIVERSITY].set_selected(true);
	
#endregion
	
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
	with (obj_catalog_item)
	{	
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