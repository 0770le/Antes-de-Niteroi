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
	if (image_index > 3 and image_index < 4) and !runned_once { 
		runned_once=true;
		alarm[ONCE] = image_speed*room_speed;
		launch(-4,0);
		audio_play_sound(snd_sword_swing, 20, false, global.volume);	
		var inst= instance_create_layer(x -30*facing,y-25, "Player", o_player_attack_hitbox);
		inst.image_xscale = facing*2;	

	}
	
	//create hitboxes during hits index
	if image_index > 4 and image_index < 8 {
		var inst= instance_create_layer(x +1*facing,y+5, "Player", o_player_attack_hitbox);
		inst.image_xscale = facing*1.5;	
	}
		
	//loop
	if floor(image_index) == 7 {
		image_index = 5;
	}	
	
	if on_ground() {//reach ground during loop
		if (image_index >= 3 and image_index < 7 ) {//stomp shake. move back
			var t1 = tilemap_get_at_pixel(global.map, x+ 65*facing,y+1);
				if t1 != VOID { 
					audio_play_sound(snd_enemy_dying, 10, false, global.volume);
					scr_screen_shake(0.3,1)	
					instance_create_layer(x+ 65*facing,y, "Dust", o_player_dust_land);
				}
			//weapon recoil
			image_index = 1;
			//anim_paused(1)
			launch(2,3,-1*facing);
			//FAZER UM ESTADO pra recuar como evade mas com o sprite do bastao pra traz
			state = states.AIR_ATTACK_END;
		}else { //anim ended. leave state
			state = states.IDLE;
		}
	}				
	
	//check state
	//after anim
	if anim_end() {
		state = states.IDLE;
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