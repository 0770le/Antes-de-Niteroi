/// @desc

get_input()

if menu_start {
	if is_open {
		close();
		set_focused(false);
	} else {
		open();
		set_focused(true);
	}
}

if is_focused {
	if attack or jump {
		selected_button.on_click();
	}
	
	if up {
		var _button = selected_group.get_previous_button();
		set_selected_button(_button);
		selected_group.set_selected_button(_button);
		
	} else if down {
		var _button = selected_group.get_next_button();
		//selecionado dentro da controladora (controla o atual com o seu grupo)
		set_selected_button(_button);
		//selecionado dentro do grupo (guardao anterior)
		selected_group.set_selected_button(_button);
	}
}
