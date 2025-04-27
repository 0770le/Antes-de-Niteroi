event_inherited();

font			= fnt_arial_medium_to_large;
font_description= fnt_arial_medium;
accent_color	= c_black;

left			= bbox_left;
right			= bbox_right;
top				= bbox_top;
bottom			= bbox_bottom;
margin_left		= 50;
margin_right	= 50;
margin_bottom	= 64;
margin_top		= 64;

is_closeable    = true;

root_menu		= undefined;
selected_item	= undefined;
has_new_items	= false;

game_version	= "v1.0.0";

starting_x		= get_sprite_center_x();
starting_y		= 300;
button_sprite   = spr_menu_button;
text_color		= c_white;
text_hover_color= c_white;
items_margin    = 70;

function draw_parent()
{
	var _xx = get_sprite_center_x();
	
	draw_sprite_ext(spr_menu_title, 0, _xx, top + 70, 1.5, 1.1, 0, c_white, 1);
	
	draw_set_font(font);
	draw_set_color(c_white);
	draw_set_halign(fa_center);
	draw_set_valign(fa_top);
	
	draw_text(_xx, top + 88, global.i18n.get_message(selected_item.parent.title)); 
}

function draw_item(_menu_item = new MenuItem(), _index = 0, _dual_column = false, _second_column = false)
{
	var _yyy = starting_y;
	
	draw_set_font(font_description);
	draw_set_color(_menu_item == selected_item ? text_hover_color : text_color);
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	
	// any node
	var _xx = starting_x;
	if (_dual_column)
	{
		_xx -= 150;
	}
	if (_second_column)
	{
		_xx += 300;
	}
	
	var _yy = _yyy + (_index * items_margin);
	
	if (_menu_item.type == MENU_TYPE.CREDITS)
	{
		draw_set_color(c_black);
		
		draw_set_halign(fa_left);
		draw_set_valign(fa_top);
		
		var _content = global.i18n.get_message(_menu_item.content);
		
		draw_text_ext(bbox_left + 100, bbox_top + 170, _content, 35, 800);
		
		draw_set_halign(fa_center);
		
		draw_text_ext(x, bbox_top + 220 + string_height_ext(_content, 35, 800), global.i18n.get_message(_menu_item.references), 40, 800);
		
		draw_set_color(c_white);
		draw_set_halign(fa_center);
		draw_set_valign(fa_middle);
	}
	else 
	{	
		draw_sprite_ext(button_sprite, _menu_item == selected_item ? 0 : 1, _xx, _yy, 1.2, 1.2, 0, c_white, 1);
	}
	
	
	
	
	
	if (_menu_item.type == MENU_TYPE.CHECKBOX || _menu_item.type == MENU_TYPE.INTEGER || _menu_item.type == MENU_TYPE.INPUT)
	{
		draw_set_halign(fa_left);
		
		draw_text(_xx - 115, _yy, global.i18n.get_message(_menu_item.title));
	}
	else if (_menu_item.type != MENU_TYPE.CREDITS)
	{
		draw_text(_xx, _yy, global.i18n.get_message(_menu_item.title));
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
	draw_set_color(accent_color);
	draw_set_font(fnt_arial_medium_to_small);
	draw_set_valign(fa_middle);
	draw_set_halign(fa_right);
	
	var _scale = global.input_manager.get_input_sprite_scale();
	
	if (global.input_manager.is_capturing)
	{
		var _cancel_sprite = global.input_manager.get_menu_action_sprite(INPUT_MENU_ACTION.TOGGLE_MENU);
		
		draw_text(right - (sprite_get_width(_cancel_sprite)*_scale) - margin_right - 10, bottom - margin_bottom, global.i18n.get_message("menu-main-cancel-capture"));
		draw_sprite_ext(_cancel_sprite, 0, right - margin_right, bottom - margin_bottom, _scale, _scale, 0, c_white, 1.0);
	}
	else 
	{
		var _confirm_sprite = global.input_manager.get_menu_action_sprite(INPUT_MENU_ACTION.CONFIRM);
		var _cancel_sprite = global.input_manager.get_menu_action_sprite(INPUT_MENU_ACTION.CANCEL);
		var _toggle_sprite = global.input_manager.get_menu_action_sprite(INPUT_MENU_ACTION.TOGGLE_MENU);
	
		draw_text(right - (sprite_get_width(_toggle_sprite)*_scale) - margin_right - 10, bottom - margin_bottom - 71, global.i18n.get_message("menu-main-close"));
		draw_sprite_ext(_toggle_sprite, 0, right - margin_right, bottom - margin_bottom - 71, _scale, _scale, 0, c_white, 1.0);
	
		draw_text(right - (sprite_get_width(_cancel_sprite)*_scale) - margin_right - 10, bottom - margin_bottom - 36, global.i18n.get_message("menu-main-back"));
		draw_sprite_ext(_cancel_sprite, 0, right - margin_right, bottom - margin_bottom - 36, _scale, _scale, 0, c_white, 1.0);
	
		draw_text(right - (sprite_get_width(_confirm_sprite)*_scale) - margin_right - 10, bottom - margin_bottom - 1, global.i18n.get_message("menu-main-confirm"));
		draw_sprite_ext(_confirm_sprite, 0, right - margin_right, bottom - margin_bottom - 1, _scale, _scale, 0, c_white, 1.0);
		
		draw_set_halign(fa_left);
		
		if (global.i18n.enable)
		{
			var _change_language_sprite = global.input_manager.get_menu_action_sprite(INPUT_MENU_ACTION.CHANGE_LANGUAGE);
		
			draw_text(left + (sprite_get_width(_toggle_sprite)*_scale) + margin_left, bottom - margin_bottom - 1, global.i18n.get_message("menu-main-change-language"));
			draw_sprite_ext(_change_language_sprite, 0, left + margin_left + 20 - _scale, bottom - margin_bottom - 1, _scale, _scale, 0, c_white, 1.0);
		}
	}
}

function draw_version()
{
	draw_set_color(accent_color);
	draw_set_font(fnt_arial_medium_to_small);
	draw_set_valign(fa_middle);
	draw_set_halign(fa_left);
	
	draw_text(left + margin_left, bottom - margin_bottom, $"A lenda de Niterói {game_version}");
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

function on_input_menu(_input = new MenuInputModel()) 
{
	if (!is_open)
	{
		if (_input.toggle_menu)
		{
			global.sound_controller.play(FMOD_EVENT.MENU_PAUSE);
			
			open();
		}
	
		return;
	}
	
	if (_input.toggle_menu && is_closeable)
	{
		selected_item = root_menu;
		
		global.sound_controller.play(FMOD_EVENT.MENU_CONFIRM_RETURN);
		
		close();
	}
	
	if (_input.change_language && global.i18n.enable)
	{
		global.i18n.change_language(global.i18n.get_next_language());
		
		global.options_controller.set_option(global.i18n.language);
	}

	if (_input.confirm) 
	{
		switch (selected_item.type)
		{
			case MENU_TYPE.NODE:
			case MENU_TYPE.TWO_COLUMNS_NODE:
				selected_item = selected_item.children[0];
				
				global.sound_controller.play(FMOD_EVENT.MENU_CONFIRM_RETURN);
			
				break;
			case MENU_TYPE.LEAF:
				// do nothing
			
				break;
			case MENU_TYPE.BUTTON:
			case MENU_TYPE.CHECKBOX:
			case MENU_TYPE.CATALOG:
			case MENU_TYPE.INPUT:
				selected_item.on_click();
				
				global.logger.debug($"{room_get_name(room)}")
				
				if (room_get_name(room) != "rm_main_menu") global.sound_controller.play(FMOD_EVENT.MENU_CONFIRM_RETURN);
			
				break;
		}
	}
	
	var _previously_selected_item = selected_item;
	if (_input.left || _input.right)
	{
		switch (selected_item.type)
		{
			case MENU_TYPE.SELECTOR:
			case MENU_TYPE.INTEGER:
				if (_input.left) selected_item.on_left();
				if (_input.right) selected_item.on_right();
				
				global.sound_controller.play(FMOD_EVENT.MENU_GENERAL);
			
				break;
			default:
				var _selected_item = selected_item;
			
				if (_input.left) selected_item = selected_item.left;
				if (_input.right) selected_item = selected_item.right;
				
				if (_selected_item != selected_item)
				{
					global.sound_controller.play(FMOD_EVENT.MENU_GENERAL);
				}
			
				break;
		}
	}
	if (_input.up) selected_item = selected_item.previous; 
	if (_input.down) selected_item = selected_item.next;
	
	if (_input.up || _input.down) 
	{
		if (_previously_selected_item != selected_item) 
		{
			global.sound_controller.play(FMOD_EVENT.MENU_GENERAL);
		}
	}

	if (_input.cancel) 
	{
		if (selected_item.parent != selected_item.parent.parent)
		{
			selected_item = selected_item.parent;
			
			global.sound_controller.play(FMOD_EVENT.MENU_CONFIRM_RETURN);
		}
		else if (is_closeable)
		{
			global.sound_controller.play(FMOD_EVENT.MENU_CONFIRM_RETURN);
			
			close();
		}
	}

}

function init()
{
	
}
