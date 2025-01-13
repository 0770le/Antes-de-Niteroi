//check hp
if(global.timer mod 10 == 0) {
	o_sound_controller.set_listener_position(x, y);
}

if(mouse_check_button_pressed(mb_middle)) {
	instance_create_layer(mouse_x,mouse_y,LAYER_INSTANCES,o_corpse);	
}

//execute state
if (!instance_exists(o_fade)) {
	script_execute(states_array[state]);
	
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
	fade_to_room(rm_cidade_velha, 3762, 415, other.facing, c_black);	
}
if(keyboard_check_pressed(vk_f2) and room != rm_akaray_1) {
	fade_to_room(rm_akaray_1, 2920, 751, other.facing, c_black);	
}
if(keyboard_check_pressed(vk_f3) and room != rm_seregipe) {
	fade_to_room(rm_seregipe, 3030, 3000, other.facing, c_black);	
}