
function player_die_state(){

	//caculate movement
	calc_entity_movement()
	
	//check state
	
		//in air
		if image_index >= 3 {
			image_index = 3;
			image_speed = 0;
		}

		//really hiting ground	
		if on_ground() {
			//avoid start next state on ground
			y += -2
			launch(2, 2,facing*-1)
			jump_dust();
			state = states.DIE_2;
			
			audio_play_sound(snd_enemy_dying, 5, false, global.volume);
	
			image_index = 0;
			image_speed = 0;
			scale_x= 1;
			scale_y= 1;
		}
	
	//apply movement
	collision();

	//apply animations
	anim();

}