function player_attack_state_1(){
	//get input
	get_input();
	
	if(image_index < 3 or image_index > 8) {
		if jump {
			jumped();
			return;
		}
		if evade {
			evaded();
			return;
		}
	}
	
	//caculate movement
//	if (image_index <= 3 ) {
	calc_movement();
//	} else {//others attacks cant change direction
//		calc_entity_movement();
//	}
//	hsp = 0;
	if hsp != 0 state = states.WALK;
	
	//check state after anim
	if anim_end() {
		state = states.IDLE;
	}	
	if evade {
		state = states.EVADE;		
	}	
	
	//power attack
	var _power_time = room_speed * 1.5;
	var _pause = 0.09* room_speed;
	if ((floor(image_index) == 2) and !runned_once) {	
		runned_once = true;
		alarm[ONCE] = _pause;
		anim_paused(_pause);
		//holding
		if attack_held {
			runned_once = false;
			attack_held_time += 1/room_speed;
		//reach power	
			if (attack_held_time > _power_time) {
				power_attack = true;
				attack_aura = instance_create_layer(side(false),bbox_top, LAYER_INSTANCES, o_light);
			}
		//allow retake the paused anim
			if (attack_held_time > _pause*room_speed) {
				alarm[ANIM_PAUSE] = 1;
				attack_held_time = 0;
				runned_once=true;
			} 	
			
		} else{
			o_sound_controller.update_event_parameter_and_play_pos(FMOD_EVENT.ATTACK_MELEE, FMOD_PARAMETER_NAME_MOVE, FMOD_PARAMETER_MOVE_VALUE_MELEE_ATTACK.GROUND,x,y);
			attack_held_time = 0;
		}
	} 
	
	
	//attacking
	//create hitboxes during hits index
	
	//above
	if (image_index >= 3 and image_index <=5)  {
		var inst= instance_create_layer(x -30*facing,y-35, LAYER_INSTANCES, o_player_attack_hitbox);
		inst.image_xscale = facing*2;	
	}
	
	//club
	if (image_index >= 3 and image_index < 8) {
		var inst= instance_create_layer(x,y+5, LAYER_INSTANCES, o_player_attack_hitbox);
		inst.image_xscale = facing*1.7;	
		
		//hit ground	
		if 	(image_index > 4	and !runned_once) {	
				runned_once = true;
				alarm[ONCE] = 20;
				
				var t1 = tilemap_get_at_pixel(global.map, x+ 65*facing,y+1);
				if t1 != VOID { 
					o_sound_controller.update_event_parameter_and_play_pos(
						FMOD_EVENT.ATTACK_HIT, 
						FMOD_PARAMETER_NAME_MOVE, 
						FMOD_PARAMETER_MOVE_VALUE_ATTACK_HIT.MELEE_GROUND,
						x, y
					);
					scr_screen_shake(0.3,1)	
					instance_create_layer(x+ 65*facing,y, LAYER_EFFECTS, o_player_dust_land);
				}
		}
	}
	
	//apply movement
	collision();
	//check player hp
	check_player_hp();
	//apply animations
	anim();

}