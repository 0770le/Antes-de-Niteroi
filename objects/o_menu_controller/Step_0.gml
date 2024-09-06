/// @desc

get_input();

if menu_start {
	if is_open and is_focused {
		close();
		set_focus(false);
	} else if !is_open {
		open();
		set_focus(true);
	}
}

process_inputs();
