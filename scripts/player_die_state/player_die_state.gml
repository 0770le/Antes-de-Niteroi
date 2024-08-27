
function player_die_state(){

	//caculate movement
	calc_entity_movement()
	
	//check state
	if anim_end() {
		state = states.DIE_2;
		image_index = 0;
		image_speed = 1;
	}
	
	if on_ground()  {
		audio_play_sound(snd_enemy_dying, 5, false);
		launch(3,3,facing*-1)
		state = states.DIE_2;
		jump_dust();
		image_index = 0;
		image_speed = 1;
		scale_x=facing;
		scale_y=1;
	} else {
		image_speed = 0;
		image_index = 2;
	}
	
	//apply movement
	collision();

	//apply animations
	anim();

}