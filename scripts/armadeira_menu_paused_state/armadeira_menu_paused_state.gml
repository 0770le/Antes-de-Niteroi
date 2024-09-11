
function armadeira_menu_paused_state(){
	
	//change state
	if !instance_exists(o_window_middle_center) {
		state = state_previous_paused;
		image_speed = image_speed_previous_paused;
		
	}
	
}
