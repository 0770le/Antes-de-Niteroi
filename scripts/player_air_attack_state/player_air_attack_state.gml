function player_air_attack_state(){
 
	//get input
	get_input();
	
	//caculate movement
	if (image_index <= 3 ) {
		calc_movement();
	} else {//others attacks cant change direction
		calc_entity_movement();
	}
	
		// light lift pull from weapon swing
	if (image_index >= 4 and image_index < 5) and !runned_once { 
		runned_once=true;
		alarm[ONCE] = image_speed*room_speed;
		launch(3,2);
		audio_play_sound(snd_sword_swing, 20, false);	
	}
	
	//create hitboxes during hits index
	if image_index >= 4 and image_index < 7 {
		var inst= instance_create_layer(x,y, "Player", o_player_attack_hitbox);
		inst.image_xscale = facing*1.4;	
	}
		
	//loop
	if floor(image_index) == 6 {
		image_index = 4;
	}	
	
	if on_ground() {//reach ground during loop
		if (image_index >= 4 and image_index <=6 ) {//stomp shake. move back
			instance_create_layer(x+ 65*facing,y, "Dust", o_player_dust_land);
			audio_play_sound(snd_enemy_dying, 10, false);
			scr_screen_shake(0.5,1.5);	
			//weapon recoil
			image_index = 8;
			anim_paused(0.2)
			launch(3,4,-1*facing);
		}else {
			state = states.IDLE;
		}
	}				
	
	//check state after anim
	if anim_end() {
		state = states.IDLE;
	}	
	if evade {
		state = states.EVADE;		
	}	
	
	//apply movement
	collision();
	//check player hp
	check_player_hp();
	//apply animations
	anim();
}