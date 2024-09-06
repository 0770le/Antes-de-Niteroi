/// @desc

get_input();

if menu_start {
	if is_open {
		close();
		
		set_focus(false);
	} else {
		open();
		
		set_focus(true);
	}
}

process_inputs();
