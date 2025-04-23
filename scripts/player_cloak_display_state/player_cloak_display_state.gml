
function player_cloak_display_state(){
	hsp = 0;
	display_timer++;
	
	//wait and jump
	if ((display_timer > room_speed *1.5 and display_timer < room_speed *1.6) and on_ground() ) {
		launch(jump_spd,0); 
		evade_dust();	
		o_sound_controller.update_event_parameter_and_play_pos(FMOD_EVENT.JUMP, FMOD_PARAMETER_NAME_MOVE, FMOD_PARAMETER_MOVE_JUMP.JUMP,x,y);
	}	
	
	//wings display
	if ((vsp > 0.5) and !runned_once) {
		runned_once = true;
		launch(jump_spd,0);
		with(instance_create_depth(x,y,depth-1,o_generic_animation)) {
			attached_to = other.id;
			attach_y_off = -33;
			attach_x_off = -5;
			sprite_index = s_player_wing;
			destroy = true;
		}
		o_sound_controller.update_event_parameter_and_play_pos(FMOD_EVENT.JUMP, FMOD_PARAMETER_NAME_MOVE, FMOD_PARAMETER_MOVE_JUMP.DOUBLE_JUMP,x,y);
	}
	
	//leave state
	if (display_timer > room_speed *2 and on_ground()) {
		state = states.IDLE;
		runned_once = false;
	}
	
	calc_entity_movement();	
	collision();
	anim();
}