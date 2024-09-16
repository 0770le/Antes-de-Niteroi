function player_attack_state(){
	//get input
	get_input();
	
	//caculate movement
	if (image_index <= 3 ) {
		calc_movement();
	} else {//others attacks cant change direction
		calc_entity_movement();
	}
	hsp = 0;
	
	//check state after anim
	if anim_end() {
		state = states.IDLE;
	}	
	if evade {
		state = states.EVADE;		
	}	
	
	//paradinha
	var _pause = 0.25;
	if (floor(image_index) == 2) and !runned_once {	
		runned_once = true;
		alarm[ONCE] = _pause* room_speed;
		anim_paused(_pause);
		
		//atacando direto se segurou mais q a pausa
		if attack_held {
			runned_once = false;
			attack_held_time += 1/room_speed;
			
			if attack_held_time > _pause*room_speed {
				alarm[ANIM_PAUSE] = 1;
				attack_held_time = 0;
				runned_once=true;
			} 	
		} else{
			attack_held_time = 0;
		}
	} 
	
	
	//attacking
	//create hitboxes during hits index
	
	//above
	if image_index >= 3 and image_index <=5  {
		var inst= instance_create_layer(x -30*facing,y-25, "Player", o_player_attack_hitbox);
		inst.image_xscale = facing*2;	
	}
	
	//club
	if image_index >= 3 and image_index < 8 {
		var inst= instance_create_layer(x + 33*facing,y, "Player", o_player_attack_hitbox);
		inst.image_xscale = facing*0.7;	
		
		//hit ground	
		if 	image_index > 4	and !runned_once {	
				runned_once = true;
				alarm[ONCE] = attack_delay;
				audio_play_sound(snd_enemy_dying, 10, false, global.volume);
				scr_screen_shake(0.3,1)	
				instance_create_layer(x+ 65*facing,y, "Dust", o_player_dust_land);
		}
	}
	
	//apply movement
	collision();
	//check player hp
	check_player_hp();
	//apply animations
	anim();

}