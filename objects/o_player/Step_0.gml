//check hp

update_saved_hp();

if(mouse_check_button_pressed(mb_middle)) {
	instance_create_layer(mouse_x,mouse_y,LAYER_INSTANCES,o_corpse);	
}

if(on_ground()) {
	jumpTimer = jumpTimerInitial;
	if(o_game.has_cloak and on_ground()) {
		jumps = 1;	
	}
} else {
	jumpTimer--;	
}

if (up or up_camera) {
	o_camera.y_offset = -80;
}
if (down or down_camera) {
	o_camera.y_offset = 0;
}


//execute state
if (!instance_exists(o_fade)) {
	var _previous_state = state;
	
	script_execute(states_array[state]);
	
	play_state_change_sounds(_previous_state, state);
	apply_state_change_triggers(_previous_state, state);
	
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

if(global.debug) {
	if(keyboard_check_pressed(vk_f1) and room != rm_cidade_velha) {
		global.fader.to_room(rm_cidade_velha, 3762, 415);
	}
	if(keyboard_check_pressed(vk_f2) and room != rm_akaray) {
		global.fader.to_room(rm_akaray, 2920, 751);
	}
	if(keyboard_check_pressed(vk_f4) and room != rm_seregipe) {
		global.fader.to_room(rm_seregipe, 3730, 2900);
	}
	if(keyboard_check_pressed(vk_f3) and room != rm_morguja_uasu) {
		global.fader.to_room(rm_morguja_uasu, 3730, 0);
	}
	if(keyboard_check_pressed(vk_f5) and room != rm_morguja_uasu) {
		global.fader.to_room(rm_morguja_uasu, 6900, 750);
	}
	if(keyboard_check_pressed(vk_f6) and room != rm_main_menu) {
		global.fader.to_room(rm_main_menu);	
	}
	if(keyboard_check_pressed(vk_f7) and room != rm_tests_augusto) {
		global.fader.to_room(rm_tests_augusto, 200, 200);	
	}
	if(keyboard_check_pressed(vk_f8) and room != rm_reri_pe) {
		global.fader.to_room(rm_reri_pe,3415,761);	
	}
	if(keyboard_check_pressed(vk_f9) and room != rm_seregipe_exploding) {
		global.fader.to_room(rm_seregipe_exploding,1606,908);	
	}

	if(keyboard_check_pressed(vk_f10) and room != rm_tests) {
		global.fader.to_room(rm_tests, 71, 395);
	}

	if(keyboard_check_pressed(vk_f11) and room != rm_tests_1) {
		global.fader.to_room(rm_tests_1, 213, 476);
	}

	if(keyboard_check_pressed(vk_f12) and room != rm_keryi) {
		global.fader.to_room(rm_keryi,2540, 1160);
	}
	
	if(keyboard_check_pressed(vk_home) and room != rm_keryi_hut) {
		global.fader.to_room(rm_keryi_hut, 200, 180);
	}

	if(keyboard_check_pressed(ord("O"))) {
		o_game.max_hp++;
		hp++;
	}

	if(keyboard_check_pressed(ord("P"))) {
		hp--;
	}
	
}