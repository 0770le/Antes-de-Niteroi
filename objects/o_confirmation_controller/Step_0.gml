/// @descr

if !is_focused {
	return;
}

get_input();
	
if up {
	move_up();
} else if down {
	move_down();
} 

if attack or jump {
	selected_button.on_click();
} else if evade or shoot {
	option_no.on_click();
}

