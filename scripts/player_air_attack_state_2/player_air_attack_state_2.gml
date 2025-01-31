function player_air_attack_state_2(){
 
	//get input
	get_input();
	
	//caculate movement
	if (image_index <= 23 ) {
		calc_movement();
	} else {//others attacks cant change direction
		calc_entity_movement();
	}//check state
	//after anim
	
	if anim_end() {
		state = states.JUMP;
		return;
	}	
	
	// light lift pull from weapon swing
	if (image_index >= 3 and image_index < 6){	
		var inst= instance_create_layer(x,y, LAYER_INSTANCES, o_player_attack_hitbox);
		inst.image_xscale = facing;	
		switch(floor(image_index)) {
			case 3:	
				inst.sprite_index = s_player_air_attack_hb_1;
				break;
			case 4:	
				inst.sprite_index = s_player_air_attack_hb_2;
				break;
			case 5:	
				inst.sprite_index = s_player_air_attack_hb_3;
				break;
		}
	}
	
	if on_ground() {//reach ground during loop
		if (image_index >= 4 and image_index < 7 ) {//stomp shake. move back
			var t1 = tilemap_get_at_pixel(global.map, x+ 65*facing,y+1);
				if t1 != VOID { 
					o_sound_controller.update_event_parameter_and_play_pos(FMOD_EVENT.ATTACK_HIT, FMOD_PARAMETER_NAME_MOVE, FMOD_PARAMETER_MOVE_VALUE_ATTACK_HIT.MELEE_GROUND);
					scr_screen_shake(0.3,1);
					instance_create_layer(x+ 35*facing,y, LAYER_EFFECTS, o_player_dust_land);
				}
			//weapon recoil
			image_index = 1;
			//anim_paused(1)
			launch(2,3,-1*facing);
			//FAZER UM ESTADO pra recuar como evade mas com o sprite do bastao pra traz
			state = states.AIR_ATTACK_END;
		}else { //anim ended. leave state
			state = states.IDLE;
			alarm[ATTACKING] = 1;
		}
	}				
	
	
	
	if evade {
		evaded();		
	}	
	
	//apply movement
	collision();
	//check player hp
	check_player_hp();
	//apply animations
	anim();
}