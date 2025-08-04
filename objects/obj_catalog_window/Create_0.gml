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

total_items = 0;

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

function get_total_unlocked_items() 
{	
	return array_length(
		array_filter(catalog_items, function (_item) { return !_item.locked })
	);
}

function draw_total_entries()
{
	draw_set_font(fnt_arial_medium_to_small);
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	draw_set_color(total_entries_text_color);
	
	var _background_x = bbox_right - 30;
	var _background_y = bbox_bottom;
	
	var _total_items = total_items;  
	var _unlocked_items = get_total_unlocked_items();
	
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

function get_label_by_type(_type = CATALOG_ITEM_TYPE.GUAJUPIA)
{
	for (var _i = 0; _i < array_length(catalog_items); _i++)
	{
		if (catalog_items[_i].type == _type) 
		{
			return catalog_items[_i].label;
		}
	}
	
	return "";
}

function create_content()
{
	//tabs

#region //// regions items
	
	catalog_tabs[CATALOG_TAB.REGIONS] = instance_create_layer(bbox_right - 20, bbox_top + 10, LAYER_GUI_CATALOG_WINDOW, obj_catalog_tab);
	catalog_tabs[CATALOG_TAB.REGIONS].label	= "menu-catalog-tab-regions";
	var _last_item = catalog_tabs[CATALOG_TAB.REGIONS].add_item(instance_create_layer(0, 0, LAYER_GUI_CATALOG_BUTTONS, obj_catalog_item));
	_last_item.label = "catalog-entry-guajupia-label";
	_last_item.set_text("catalog-entry-guajupia-text");
	_last_item.type = CATALOG_ITEM_TYPE.GUAJUPIA;
	
	_last_item = catalog_tabs[CATALOG_TAB.REGIONS].add_item(instance_create_layer(0, 0, LAYER_GUI_CATALOG_BUTTONS, obj_catalog_item));
	_last_item.label = "catalog-entry-cidade-velha-label";
	_last_item.set_text("catalog-entry-cidade-velha-text");
	_last_item.type = CATALOG_ITEM_TYPE.CIDADE_VELHA;
	
	_last_item = catalog_tabs[CATALOG_TAB.REGIONS].add_item(instance_create_layer(0, 0, LAYER_GUI_CATALOG_BUTTONS, obj_catalog_item));
	_last_item.label = "catalog-entry-nheteroia-label";
	_last_item.set_text("catalog-entry-nheteroia-text");
	_last_item.type = CATALOG_ITEM_TYPE.NHETEROIA;	
	
	_last_item = catalog_tabs[CATALOG_TAB.REGIONS].add_item(instance_create_layer(0, 0, LAYER_GUI_CATALOG_BUTTONS, obj_catalog_item));
	_last_item.label = "catalog-entry-keriy-label";
	_last_item.set_text("catalog-entry-keriy-text");
	_last_item.type = CATALOG_ITEM_TYPE.KERIY;
	
	_last_item = catalog_tabs[CATALOG_TAB.REGIONS].add_item(instance_create_layer(0, 0, LAYER_GUI_CATALOG_BUTTONS, obj_catalog_item));
	_last_item.label = "catalog-entry-akaray-label";
	_last_item.set_text("catalog-entry-akaray-text");
	_last_item.type = CATALOG_ITEM_TYPE.AKARAY;	
	
	_last_item = catalog_tabs[CATALOG_TAB.REGIONS].add_item(instance_create_layer(0, 0, LAYER_GUI_CATALOG_BUTTONS, obj_catalog_item));
	_last_item.label = "catalog-entry-morguja-uausu-label";
	_last_item.set_text("catalog-entry-morguja-uausu-text");
	_last_item.type = CATALOG_ITEM_TYPE.MORGUJA_UASU;	
	
	_last_item = catalog_tabs[CATALOG_TAB.REGIONS].add_item(instance_create_layer(0, 0, LAYER_GUI_CATALOG_BUTTONS, obj_catalog_item));
	_last_item.label = "catalog-entry-kurumure-label";
	_last_item.set_text("catalog-entry-kurumure-text");
	_last_item.type = CATALOG_ITEM_TYPE.KURUMURE;
	
	_last_item = catalog_tabs[CATALOG_TAB.REGIONS].add_item(instance_create_layer(0, 0, LAYER_GUI_CATALOG_BUTTONS, obj_catalog_item));
	_last_item.label = "catalog-entry-itaoka-label";
	_last_item.set_text("catalog-entry-itaoka-text");
	_last_item.type = CATALOG_ITEM_TYPE.ITAOKA;
	
	_last_item = catalog_tabs[CATALOG_TAB.REGIONS].add_item(instance_create_layer(0, 0, LAYER_GUI_CATALOG_BUTTONS, obj_catalog_item));
	_last_item.label = "catalog-entry-itaoka-ultimo-bastiao-label";
	_last_item.set_text("catalog-entry-itaoka-ultimo-bastiao-text");
	_last_item.type = CATALOG_ITEM_TYPE.ITAOKA_FORT;
	
	_last_item = catalog_tabs[CATALOG_TAB.REGIONS].add_item(instance_create_layer(0, 0, LAYER_GUI_CATALOG_BUTTONS, obj_catalog_item));
	_last_item.label = "catalog-entry-ilha-de-serigipe-label";
	_last_item.set_text("catalog-entry-ilha-de-serigipe-text");
	_last_item.type = CATALOG_ITEM_TYPE.SEREGIPE;
	
	_last_item = catalog_tabs[CATALOG_TAB.REGIONS].add_item(instance_create_layer(0, 0, LAYER_GUI_CATALOG_BUTTONS, obj_catalog_item));
	_last_item.label = "catalog-entry-karioca-label";
	_last_item.set_text("catalog-entry-karioca-text");
	_last_item.type = CATALOG_ITEM_TYPE.KARIOCA;
	
	_last_item = catalog_tabs[CATALOG_TAB.REGIONS].add_item(instance_create_layer(0, 0, LAYER_GUI_CATALOG_BUTTONS, obj_catalog_item));
	_last_item.label = "catalog-entry-karioca-reripe-label";
	_last_item.set_text("catalog-entry-karioca-reripe-text");
	_last_item.type = CATALOG_ITEM_TYPE.RERI_PE;
	
	_last_item = catalog_tabs[CATALOG_TAB.REGIONS].add_item(instance_create_layer(0, 0, LAYER_GUI_CATALOG_BUTTONS, obj_catalog_item));
	_last_item.label = "catalog-entry-guyraguasuunae-label";
	_last_item.set_text("catalog-entry-guyraguasuunae-text");
	_last_item.type = CATALOG_ITEM_TYPE.GUYRAGUASU_UNAE;
	
	_last_item = catalog_tabs[CATALOG_TAB.REGIONS].add_item(instance_create_layer(0, 0, LAYER_GUI_CATALOG_BUTTONS, obj_catalog_item));
	_last_item.label = "catalog-entry-jabebiracica-label";
	_last_item.set_text("catalog-entry-jabebiracica-text");
	_last_item.type = CATALOG_ITEM_TYPE.JABEBIRACICA;
	
	_last_item = catalog_tabs[CATALOG_TAB.REGIONS].add_item(instance_create_layer(0, 0, LAYER_GUI_CATALOG_BUTTONS, obj_catalog_item));
	_last_item.label = "catalog-entry-paranapua-label";
	_last_item.set_text("catalog-entry-paranapua-text");
	_last_item.type = CATALOG_ITEM_TYPE.PARANAPUA;
	
	_last_item = catalog_tabs[CATALOG_TAB.REGIONS].add_item(instance_create_layer(0, 0, LAYER_GUI_CATALOG_BUTTONS, obj_catalog_item));
	_last_item.label = "catalog-entry-paranapua-paranacupu-label";
	_last_item.set_text("catalog-entry-paranapua-paranacupu-text");
	_last_item.type = CATALOG_ITEM_TYPE.PARANACUPU;

#endregion	
	
	catalog_tabs[CATALOG_TAB.REGIONS].set_selected(false);
	
#region //// history items
	catalog_tabs[CATALOG_TAB.HISTORY] = instance_create_layer(catalog_tabs[CATALOG_TAB.REGIONS].bbox_left, catalog_tabs[CATALOG_TAB.REGIONS].y, LAYER_GUI_CATALOG_WINDOW, obj_catalog_tab);
	catalog_tabs[CATALOG_TAB.HISTORY].label	= "menu-catalog-tab-history";
	_last_item = catalog_tabs[CATALOG_TAB.HISTORY].add_item(instance_create_layer(0, 0, LAYER_GUI_CATALOG_BUTTONS, obj_catalog_item));
	_last_item.label = "catalog-entry-tupinamba-label";
	_last_item.set_text("catalog-entry-tupinamba-text");
	_last_item.type = CATALOG_ITEM_TYPE.TUPINAMBA;
	
	_last_item = catalog_tabs[CATALOG_TAB.HISTORY].add_item(instance_create_layer(0, 0, LAYER_GUI_CATALOG_BUTTONS, obj_catalog_item));
	_last_item.label = "catalog-entry-morubixaba-label";
	_last_item.set_text("catalog-entry-morubixaba-text");
	_last_item.type = CATALOG_ITEM_TYPE.MORUBIXABA;
	
	_last_item = catalog_tabs[CATALOG_TAB.HISTORY].add_item(instance_create_layer(0, 0, LAYER_GUI_CATALOG_BUTTONS, obj_catalog_item));
	_last_item.label = "catalog-entry-araryboia-label";
	_last_item.set_text("catalog-entry-araryboia-text"); 
	_last_item.type = CATALOG_ITEM_TYPE.ARARYBOIA;
	
	_last_item = catalog_tabs[CATALOG_TAB.HISTORY].add_item(instance_create_layer(0, 0, LAYER_GUI_CATALOG_BUTTONS, obj_catalog_item));
	_last_item.label = "catalog-entry-kunumiuasu-label";
	_last_item.set_text("catalog-entry-kunumiuasu-text");
	_last_item.type = CATALOG_ITEM_TYPE.KUNUMIUASU;
	
	_last_item = catalog_tabs[CATALOG_TAB.HISTORY].add_item(instance_create_layer(0, 0, LAYER_GUI_CATALOG_BUTTONS, obj_catalog_item));
	_last_item.label = "catalog-entry-taba-label";
	_last_item.set_text("catalog-entry-taba-text");
	_last_item.type = CATALOG_ITEM_TYPE.TABA;
	
	_last_item = catalog_tabs[CATALOG_TAB.HISTORY].add_item(instance_create_layer(0, 0, LAYER_GUI_CATALOG_BUTTONS, obj_catalog_item));
	_last_item.label = "catalog-entry-maloca-label";
	_last_item.set_text("catalog-entry-maloca-text");
	_last_item.type = CATALOG_ITEM_TYPE.MALOCA;
	
	_last_item = catalog_tabs[CATALOG_TAB.HISTORY].add_item(instance_create_layer(0, 0, LAYER_GUI_CATALOG_BUTTONS, obj_catalog_item));
	_last_item.label = "catalog-entry-tamoios-label";
	_last_item.set_text("catalog-entry-tamoios-text");
	_last_item.type = CATALOG_ITEM_TYPE.TAMOIOS;
	
	_last_item = catalog_tabs[CATALOG_TAB.HISTORY].add_item(instance_create_layer(0, 0, LAYER_GUI_CATALOG_BUTTONS, obj_catalog_item));
	_last_item.label = "catalog-entry-temininos-label";
	_last_item.set_text("catalog-entry-temininos-text");
	_last_item.type = CATALOG_ITEM_TYPE.TEMININOS;
	
	_last_item = catalog_tabs[CATALOG_TAB.HISTORY].add_item(instance_create_layer(0, 0, LAYER_GUI_CATALOG_BUTTONS, obj_catalog_item));
	_last_item.label = "catalog-entry-maranauasu-label";
	_last_item.set_text("catalog-entry-maranauasu-text");
	_last_item.type = CATALOG_ITEM_TYPE.MARANA_UASU;
	
	_last_item = catalog_tabs[CATALOG_TAB.HISTORY].add_item(instance_create_layer(0, 0, LAYER_GUI_CATALOG_BUTTONS, obj_catalog_item));
	_last_item.label = "catalog-entry-truchment-label";
	_last_item.set_text("catalog-entry-truchment-text");
	_last_item.type = CATALOG_ITEM_TYPE.TRUCHEMENT;
	
	_last_item = catalog_tabs[CATALOG_TAB.HISTORY].add_item(instance_create_layer(0, 0, LAYER_GUI_CATALOG_BUTTONS, obj_catalog_item));
	_last_item.label = "catalog-entry-cristaos-label";
	_last_item.set_text("catalog-entry-cristaos-text");
	_last_item.type = CATALOG_ITEM_TYPE.CRISTAOS;
	
	_last_item = catalog_tabs[CATALOG_TAB.HISTORY].add_item(instance_create_layer(0, 0, LAYER_GUI_CATALOG_BUTTONS, obj_catalog_item));
	_last_item.label = "catalog-entry-ibirapema-label";
	_last_item.set_text("catalog-entry-ibirapema-text");
	_last_item.type = CATALOG_ITEM_TYPE.IBIRAPEMA;
	
	_last_item = catalog_tabs[CATALOG_TAB.HISTORY].add_item(instance_create_layer(0, 0, LAYER_GUI_CATALOG_BUTTONS, obj_catalog_item));
	_last_item.label = "catalog-entry-arco-e-flecha-label";
	_last_item.set_text("catalog-entry-arco-e-flecha-text");
	_last_item.type = CATALOG_ITEM_TYPE.URAPACA;

	_last_item = catalog_tabs[CATALOG_TAB.HISTORY].add_item(instance_create_layer(0, 0, LAYER_GUI_CATALOG_BUTTONS, obj_catalog_item));
	_last_item.label = "catalog-entry-manto-sagrado-label";
	_last_item.set_text("catalog-entry-manto-sagrado-text");
	_last_item.type = CATALOG_ITEM_TYPE.ASSOJABA;
	
	_last_item = catalog_tabs[CATALOG_TAB.HISTORY].add_item(instance_create_layer(0, 0, LAYER_GUI_CATALOG_BUTTONS, obj_catalog_item));
	_last_item.label = "catalog-entry-mucurana-label";
	_last_item.set_text("catalog-entry-mucurana-text");
	_last_item.type = CATALOG_ITEM_TYPE.MUCURANA;
	
	_last_item = catalog_tabs[CATALOG_TAB.HISTORY].add_item(instance_create_layer(0, 0, LAYER_GUI_CATALOG_BUTTONS, obj_catalog_item));
	_last_item.label = "catalog-entry-trafico-label";
	_last_item.set_text("catalog-entry-trafico-text");
	_last_item.type = CATALOG_ITEM_TYPE.TRAFICO;
	
#endregion
	
	catalog_tabs[CATALOG_TAB.HISTORY].set_selected(false);
	
#region //// biodiversity items
	catalog_tabs[CATALOG_TAB.BIODIVERSITY] = instance_create_layer(catalog_tabs[CATALOG_TAB.HISTORY].bbox_left, catalog_tabs[CATALOG_TAB.REGIONS].y, LAYER_GUI_CATALOG_WINDOW, obj_catalog_tab);
	catalog_tabs[CATALOG_TAB.BIODIVERSITY].label = "menu-catalog-tab-biodiversity";
	_last_item = catalog_tabs[CATALOG_TAB.BIODIVERSITY].add_item(instance_create_layer(0, 0, LAYER_GUI_CATALOG_BUTTONS, obj_catalog_item));
	_last_item.label = "catalog-entry-cobra-arara-label";
	_last_item.set_text("catalog-entry-cobra-arara-text");
	_last_item.type = CATALOG_ITEM_TYPE.COBRA_ARARA;
	
	_last_item = catalog_tabs[CATALOG_TAB.BIODIVERSITY].add_item(instance_create_layer(0, 0, LAYER_GUI_CATALOG_BUTTONS, obj_catalog_item));
	_last_item.label = "catalog-entry-maracaja-label";
	_last_item.set_text("catalog-entry-maracaja-text");
	_last_item.type = CATALOG_ITEM_TYPE.MARACAJA;
	
	_last_item = catalog_tabs[CATALOG_TAB.BIODIVERSITY].add_item(instance_create_layer(0, 0, LAYER_GUI_CATALOG_BUTTONS, obj_catalog_item));
	_last_item.label = "catalog-entry-arara-caninde-label";
	_last_item.set_text("catalog-entry-arara-caninde-text");
	_last_item.type = CATALOG_ITEM_TYPE.ARARA_CANINDE;
	
	_last_item = catalog_tabs[CATALOG_TAB.BIODIVERSITY].add_item(instance_create_layer(0, 0, LAYER_GUI_CATALOG_BUTTONS, obj_catalog_item));
	_last_item.label = "catalog-entry-arara-azul-label";
	_last_item.set_text("catalog-entry-arara-azul-text");
	_last_item.type = CATALOG_ITEM_TYPE.ARARA_AZUL;
	
	_last_item = catalog_tabs[CATALOG_TAB.BIODIVERSITY].add_item(instance_create_layer(0, 0, LAYER_GUI_CATALOG_BUTTONS, obj_catalog_item));
	_last_item.label = "catalog-entry-arara-vermelha-label";
	_last_item.set_text("catalog-entry-arara-vermelha-text");
	_last_item.type = CATALOG_ITEM_TYPE.ARARA_VERMELHA;
	
	_last_item = catalog_tabs[CATALOG_TAB.BIODIVERSITY].add_item(instance_create_layer(0, 0, LAYER_GUI_CATALOG_BUTTONS, obj_catalog_item));
	_last_item.label = "catalog-entry-guara-label";
	_last_item.set_text("catalog-entry-guara-text");
	_last_item.type = CATALOG_ITEM_TYPE.GUARA;
	
	_last_item = catalog_tabs[CATALOG_TAB.BIODIVERSITY].add_item(instance_create_layer(0, 0, LAYER_GUI_CATALOG_BUTTONS, obj_catalog_item));
	_last_item.label = "catalog-entry-armadeira-label";
	_last_item.set_text("catalog-entry-armadeira-text");
	_last_item.type = CATALOG_ITEM_TYPE.ARMADEIRA;
	
	_last_item = catalog_tabs[CATALOG_TAB.BIODIVERSITY].add_item(instance_create_layer(0, 0, LAYER_GUI_CATALOG_BUTTONS, obj_catalog_item));
	_last_item.label = "catalog-entry-jararaca-label";
	_last_item.set_text("catalog-entry-jararaca-text");
	_last_item.type = CATALOG_ITEM_TYPE.JARARACA;
	
	_last_item = catalog_tabs[CATALOG_TAB.BIODIVERSITY].add_item(instance_create_layer(0, 0, LAYER_GUI_CATALOG_BUTTONS, obj_catalog_item));
	_last_item.label = "catalog-entry-onca-pintada-label";
	_last_item.set_text("catalog-entry-onca-pintada-text");	
	_last_item.type = CATALOG_ITEM_TYPE.IAGUARA;
	
	_last_item = catalog_tabs[CATALOG_TAB.BIODIVERSITY].add_item(instance_create_layer(0, 0, LAYER_GUI_CATALOG_BUTTONS, obj_catalog_item));
	_last_item.label = "catalog-entry-harpia-label";
	_last_item.set_text("catalog-entry-harpia-text");	
	_last_item.type = CATALOG_ITEM_TYPE.HARPIA;
	
	_last_item = catalog_tabs[CATALOG_TAB.BIODIVERSITY].add_item(instance_create_layer(0, 0, LAYER_GUI_CATALOG_BUTTONS, obj_catalog_item));
	_last_item.label = "catalog-entry-urucum-e-jenipapo-label";
	_last_item.set_text("catalog-entry-urucum-e-jenipapo-text");
	_last_item.type = CATALOG_ITEM_TYPE.URUCUM_GENIPAPO;
	
	_last_item = catalog_tabs[CATALOG_TAB.BIODIVERSITY].add_item(instance_create_layer(0, 0, LAYER_GUI_CATALOG_BUTTONS, obj_catalog_item));
	_last_item.label = "catalog-entry-pau-brasil-label";
	_last_item.set_text("catalog-entry-pau-brasil-text");
	_last_item.type = CATALOG_ITEM_TYPE.PAU_BRASIL;
	
	_last_item = catalog_tabs[CATALOG_TAB.BIODIVERSITY].add_item(instance_create_layer(0, 0, LAYER_GUI_CATALOG_BUTTONS, obj_catalog_item));
	_last_item.label = "catalog-entry-bromelias-label";
	_last_item.set_text("catalog-entry-bromelias-text");
	_last_item.type = CATALOG_ITEM_TYPE.BROMELIAS;
	
	_last_item = catalog_tabs[CATALOG_TAB.BIODIVERSITY].add_item(instance_create_layer(0, 0, LAYER_GUI_CATALOG_BUTTONS, obj_catalog_item));
	_last_item.label = "catalog-entry-orquideas-label";
	_last_item.set_text("catalog-entry-orquideas-text");
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
	global.catalog_window = self;
	
	create_content();
	
	total_items = array_length(catalog_items);
	
	unlock_saved_items();
	
	close();
	
	global.input_manager.subscribe(self, INPUT_TYPE.MENU);
}

init();