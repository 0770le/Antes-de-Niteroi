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
selected_tab		= noone;

function open()
{
	is_open = true;
	
	global.initializer.focus(object_index);
	
	selected_tab.toggle_items(true);
	
	global.catalog_controller.show_all();
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
}

function draw_controller_buttons()
{
	draw_set_color(c_black);
	draw_set_font(fnt_arial_medium_to_small);
	draw_set_valign(fa_middle);
	draw_set_halign(fa_right);
	
	draw_text(bbox_right - sprite_get_width(spr_gamepad_xbox_b) - 70, bbox_bottom - 99, "Fechar");
	draw_sprite_ext(spr_gamepad_xbox_start, 0, bbox_right - 50, bbox_bottom - 100, 2, 2, 0, c_white, 1.0);
	
	draw_text(bbox_right - sprite_get_width(spr_gamepad_xbox_b) - 70, bbox_bottom - 64, "Voltar");
	draw_sprite_ext(spr_gamepad_xbox_b, 0, bbox_right - 50, bbox_bottom - 65, 2, 2, 0, c_white, 1.0);
}

function on_input_menu(_input = new MenuInputModel())
{
	if (!is_open)
	{
		return;
	}
	
	if (_input.cancel) 
	{
		_input.toggle_menu = true;
		
		global.menu_controller.on_input_menu(_input);
		
		close();
	}
	
	if (_input.left || _input.right)
	{
		var _previous = selected_tab;
		
		selected_tab.set_selected(false);
		
		selected_tab = _input.left ? selected_tab.previous : selected_tab.next;
		
		selected_tab.set_selected(true);
		
		if (_previous != selected_tab && _previous.selected_item != noone && selected_tab.selected_item != noone)
		{
			_previous.selected_item.set_hover(false);
			
			selected_tab.selected_item = selected_tab.items[0];
			
			selected_tab.selected_item.set_hover(true);
		}
	}
	
	if (_input.up || _input.down)
	{
		selected_tab.selected_item.set_hover(false);
		
		selected_tab.selected_item = _input.up ? selected_tab.selected_item.previous : selected_tab.selected_item.next;
		
		selected_tab.selected_item.set_hover(true);
	}
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
	_last_item.label = "Nova História";
	_last_item.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. In non lacus ac nunc elementum euismod. Phasellus eros diam, convallis quis lorem eu, aliquam viverra lorem. Donec dapibus odio eu ipsum sagittis, sed convallis turpis finibus. Mauris id mollis augue. Vestibulum egestas nisl id lorem egestas, in efficitur justo rutrum. Proin eu leo quis justo bibendum accumsan eu non lorem. Vivamus consectetur sem nulla, nec tempor elit consequat sed.";
	_last_item.image = spr_catalog_image_5;
	catalog_tabs[CATALOG_TAB.REGIONS].set_selected(false);
	
	//// history items
	catalog_tabs[CATALOG_TAB.HISTORY] = instance_create_layer(catalog_tabs[CATALOG_TAB.REGIONS].bbox_left, catalog_tabs[CATALOG_TAB.REGIONS].y, LAYER_GUI_CATALOG_WINDOW, obj_catalog_tab);
	catalog_tabs[CATALOG_TAB.HISTORY].label	= "História";
	_last_item = catalog_tabs[CATALOG_TAB.HISTORY].add_item(instance_create_layer(bbox_left + 30, bbox_top + 48, LAYER_GUI_CATALOG_BUTTONS, obj_catalog_item));
	_last_item.label = "Cidade-Velha";
	_last_item.text = "Situada entre a Pedra da Urca e a Cara de Cão, foi escolhida em 1567 como o ponto inicial de ocupação para a retomada da Baía dos Franceses. A topografia da região, com suas colinas e enseadas, oferecia um local ideal para a construção de fortificações.";
	_last_item.image = spr_catalog_image_4;
	catalog_tabs[CATALOG_TAB.HISTORY].set_selected(false);
	
	//// biodiversity items
	catalog_tabs[CATALOG_TAB.BIODIVERSITY] = instance_create_layer(catalog_tabs[CATALOG_TAB.HISTORY].bbox_left, catalog_tabs[CATALOG_TAB.REGIONS].y, LAYER_GUI_CATALOG_WINDOW, obj_catalog_tab);
	catalog_tabs[CATALOG_TAB.BIODIVERSITY].label = "Biodiversidade";
	_last_item = catalog_tabs[CATALOG_TAB.BIODIVERSITY].add_item(instance_create_layer(bbox_left + 30, bbox_top + 48, LAYER_GUI_CATALOG_BUTTONS, obj_catalog_item));
	_last_item.label = "Arara-canindé";
	_last_item.text = "A arara-canindé (Ara ararauna) é uma ave impressionante, famosa por sua plumagem azul e amarela. Os tupinambás a adoravam, capturando-a viva para usar suas penas em rituais importantes, mas sem causar danos, soltando-a em seguida. Social e inteligente, essa arara tem um bico forte para quebrar sementes e desempenha um papel crucial na dispersão de sementes nas florestas tropicais.";
	
	_last_item = catalog_tabs[CATALOG_TAB.BIODIVERSITY].add_item(instance_create_layer(_last_item.x, _last_item.bbox_bottom + 20, LAYER_GUI_CATALOG_BUTTONS, obj_catalog_item));
	_last_item.label = "Armadeira";
	_last_item.text = "A aranha-armadeira (Phoneutria) é considerada a mais venenosa do mundo, podendo atingir até 17 cm de comprimento. Conhecida por seu comportamento agressivo, é extremamente veloz e capaz de saltar até 40 cm. Quando ameaçada, adota uma postura defensiva característica,'se armando' ao levantar as patas dianteiras em posição de ataque.";
	_last_item.image = spr_catalog_image_2;
	
	_last_item = catalog_tabs[CATALOG_TAB.BIODIVERSITY].add_item(instance_create_layer(_last_item.x, _last_item.bbox_bottom + 20, LAYER_GUI_CATALOG_BUTTONS, obj_catalog_item));
	_last_item.label = "Francês";
	_last_item.text = "Franceses são inimigos!";
	_last_item.image = spr_catalog_image_3;
	catalog_tabs[CATALOG_TAB.BIODIVERSITY].set_selected(true);
	
	// tabs chaining
	catalog_tabs[CATALOG_TAB.REGIONS].previous = catalog_tabs[CATALOG_TAB.HISTORY];
	catalog_tabs[CATALOG_TAB.HISTORY].previous = catalog_tabs[CATALOG_TAB.BIODIVERSITY];
	catalog_tabs[CATALOG_TAB.BIODIVERSITY].next = catalog_tabs[CATALOG_TAB.HISTORY];
	catalog_tabs[CATALOG_TAB.HISTORY].next = catalog_tabs[CATALOG_TAB.REGIONS];
	
	
	// tab selection
	selected_tab = catalog_tabs[CATALOG_TAB.BIODIVERSITY];
}

function init()
{
	create_content();
	
	close();
	
	global.input_manager.subscribe(self, INPUT_TYPE.MENU);
}

init();