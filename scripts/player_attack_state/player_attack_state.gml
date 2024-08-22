function player_attack_state(){
 
	//get input
	get_input();
	
	//caculate movement
	if (attack_type == attacks.STRIKE) or (alarm[ATTACKING] == -1) {
		calc_movement();
	} else {//others attacks cant change direction
		calc_entity_movement();
	}
	
	//check state after anim
	if anim_end() {
		if !on_ground() {
			state= states.JUMP  
		}else {
			state = states.IDLE;
		}
	}	
		
	if evade {
		state = states.EVADE;		
	}	
	
	//run once. choose attack type
	if can_attack and (attack_type == attacks.NONE) {		
		can_attack = false;
		//leap attack
		if !on_ground() {
			attack_type = attacks.LEAP;
		//lunge 
		} else if down {
			attack_type = attacks.LUNGE;
		//strike
		} else if (hsp != 0) {
			attack_type = attacks.STRIKE;
			hsp =+ 3*facing;
		//blow
		} else {
			attack_type = attacks.BLOW;	
		}	
	}
		
	//attacking
	switch(attack_type) {
		case attacks.NONE:
		break;
		
		case attacks.LEAP:
			// light lift pull from weapon swing
			if (image_index >= 4) and image_index < 5 { 
				//sound swing moment - once	
				if !audio_is_playing(snd_pickup_hp) { 
					audio_play_sound(snd_pickup_hp, 20, false);
					vsp =+ -2;
					hsp =+ 6 *facing;		
				}
			}
			//create hitboxes during hits index
			if image_index >= 5 {
				var inst= instance_create_layer(x,y, "Player", o_player_attack_hitbox);
				inst.image_xscale = facing;	
				show_debug_message("image index = " + string(image_index));
				
				show_debug_message("image speed = " + string(image_speed));
				//reach ground	
				if on_ground() {//stomp shake. move back				
					if !audio_is_playing(snd_enemy_dying) {
						audio_play_sound(snd_enemy_dying, 10, false);
						scr_screen_shake(1,2)	
						//weapon recoil
						image_index = 4
						image_speed = 0;
						vsp =+ -4;
						hsp =+ 2 * -1* facing; 
					} else {
						//allow new move
						image_speed = 1;
						image_index= image_number;
						attack_type = attacks.NONE; 	
					}
				} else { //!on_ground
					if (image_index >= 7) {//loop
						image_index = 5;
						show_debug_message("ENTROU LOOP");
					} 	
				}
			}				

		break;
		
		case attacks.LUNGE:
			//create hitbox
			if image_index >= 1 and image_index <= 3 {
				var inst= instance_create_layer(x,y, "Player", o_player_attack_hitbox);
				inst.image_xscale = facing;
				// sound (batle cry and step, vush?) 
				if (image_index == 2) {
					if (!audio_is_playing(snd_enemy_dying)) { //choose longest sound
						audio_play_sound(snd_enemy_dying, 10, false);
						//foward advance //make dust
						if (!instance_exists( o_player_dust_jump)) {
							jump_dust();
							hsp =+ 5*facing;
						}					
					}
				}		
			
			}
		break;
			
		case attacks.STRIKE: //
			//create hitbox
			if image_index >= 3 and image_index <= 4 {
				var inst= instance_create_layer(x,y, "Player", o_player_attack_hitbox);
				inst.image_xscale = facing;
				//sound 
				if (image_index == 1) {
					audio_play_sound(snd_sword_swing, 20, false);
				}
			}
		break;
		
		case attacks.BLOW:// 8 para 9 acerta o chao
				//create hitbox
			if image_index >=3 and image_index < 4 {
				var inst= instance_create_layer(x,y, "Player", o_player_attack_hitbox);
				inst.image_xscale = facing*1.8;
				//sound 
				if (image_index == 1) {
					audio_play_sound(snd_sword_swing, 20, false);
				}
			}
		break;
	}
	
	
	//allow nem attack
	if state != states.ATTACK {
		attack_type = attacks.NONE;
		alarm[ATTACKING] = attack_delay;
	}
	
	//apply movement
	collision();
	//check player hp
	check_player_hp();
	//apply animations
	anim();

}