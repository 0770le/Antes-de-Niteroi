if (!is_open)
{
	if (keyboard_check_released(toggle_key))
	{
		open();
	}
	
	return;
} 

if (keyboard_check_pressed(vk_space)) 
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

if (keyboard_check_pressed(vk_up)) 
{
	selected_item = selected_item.previous;
}

if (keyboard_check_pressed(vk_down)) 
{
	selected_item = selected_item.next;
}

if (keyboard_check_pressed(vk_escape)) 
{
	if (selected_item.parent != selected_item.parent.parent)
	{
		selected_item = selected_item.parent;
	}
	else 
	{
		is_open = false;
	}
}

if (mouse_check_button_released(mb_left))
{
	show_debug_message("x: " + string(mouse_x) + "; y: " + string(mouse_y));
}