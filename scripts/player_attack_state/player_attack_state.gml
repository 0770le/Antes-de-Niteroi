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
	if (floor(image_index) == 2) and !runned_once {
		var _time = 0.28;
		anim_paused(_time);
		runned_once = true;
		alarm[ONCE] = _time* room_speed;
	} 
	if (floor(image_index) == 2 and attack_held) {
		runned_once=false;
	}
	
	//attacking
	//create hitboxes during hits index
	if image_index >= 3 {
		var inst= instance_create_layer(x,y, "Player", o_player_attack_hitbox);
		inst.image_xscale = facing*1.4;	
		
		//hit ground	
		if 	image_index > 8	and !runned_once {	
				runned_once = true;
				alarm[ONCE] = attack_delay;
				audio_play_sound(snd_enemy_dying, 10, false);
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