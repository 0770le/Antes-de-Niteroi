
function player_die_state(){

	//caculate movement
	calc_entity_movement()
	
	show_debug_message("image index = " + string(image_index));	
	show_debug_message("image speed = " + string(image_speed));
	show_debug_message("state = " + string(state));
	show_debug_message("runned_once = " + string(runned_once));
	show_debug_message("top" + string( bbox_top));
	show_debug_message("bottom " + string( bbox_bottom));
	show_debug_message("chao (319) " + string( y));
	show_debug_message("---");
	
	//check state
	
		//in air
		if image_index > 3 {
			image_index = 3;
			image_speed = 0;
		}

		//really hiting ground	
		if on_ground() {
			
			y += -4
			launch(vsp*1.5, hsp*1.5,facing*-1)
			
			state = states.DIE_2;
			
			audio_play_sound(snd_enemy_dying, 5, false);
			evade_dust();
			image_index = 0;
			image_speed = 0;
			scale_x=facing;
			scale_y=1;
		}
	
	//apply movement
	collision();

	//apply animations
	anim();

}