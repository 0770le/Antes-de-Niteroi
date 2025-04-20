
function player_evade_state(){

	calc_entity_movement(global.grav*0.9)
	if(anim_end()) {
		image_speed = 0;	
	}

	if (recover_time++ >= 30 or on_ground()) {
		//change state
		hsp=0;
		state = states.IDLE;
		call_later(0.6,time_source_units_seconds,function(){can_take_dmg = true;} ,false);
		image_speed = 1;
		
		o_sound_controller.update_event_parameter_and_play_pos(FMOD_EVENT.EVADE, FMOD_PARAMETER_NAME_MOVE, FMOD_PARAMETER_MOVE_EVADE.LAND, x, y);
	}
	
	//apply movement
	collision();
	//check player hp
	check_player_hp();
	//apply animations
	anim();

}