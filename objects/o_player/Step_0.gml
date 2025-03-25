//check hp

update_saved_hp();

if(mouse_check_button_pressed(mb_middle)) {
	instance_create_layer(mouse_x,mouse_y,LAYER_INSTANCES,o_corpse);	
}

if(o_game.has_cloak and on_ground()) {
	jumps = 1;	
}


//execute state
if (!instance_exists(o_fade)) {
	var _previous_state = state;
	
	script_execute(states_array[state]);
	
	play_state_change_sounds(_previous_state, state);
	
	//ensure facing is never 0
	if facing == 0 {facing=1;}
	
	//hide
	if (hidden) {
		image_alpha = lerp (image_alpha, 0.2, 0.1);
	
	} else {
		image_alpha = lerp (image_alpha, 1, 0.1);
	}
	
} else { //com fade
	
	//stop the animation playing
	if (state != states.DIE_2) {
		image_index = 0;
	}
	
	
}

if(keyboard_check_pressed(vk_f1) and room != rm_cidade_velha) {
	fade_to_room(rm_cidade_velha, 3762, 415, other.facing);	
}
if(keyboard_check_pressed(vk_f2) and room != rm_akaray_1) {
	fade_to_room(rm_akaray_1, 2920, 751, other.facing);
}
if(keyboard_check_pressed(vk_f3) and room != rm_seregipe) {
	fade_to_room(rm_seregipe, 3730, 2900, other.facing);	
}
if(keyboard_check_pressed(vk_f4) and room != rm_morguja_uasu) {
	fade_to_room(rm_morguja_uasu, 4188, 1234, other.facing);	
}
if(keyboard_check_pressed(vk_f5) and room != rm_morguja_uasu) {
	fade_to_room(rm_morguja_uasu, 6900, 750, other.facing);	
}
if(keyboard_check_pressed(vk_f6) and room != rm_main_menu) {
	fade_to_room(rm_main_menu, 3762, 415, other.facing);	
}
