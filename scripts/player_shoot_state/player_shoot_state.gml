function player_shoot_state() {//o tempo pra dar o tiro é o tempo do sprite
	
	
	//get input
	get_input();

	calc_movement();
	//apply movement
	
	//nao andar no chao
	if on_ground() {
		hsp=0;
	}	
	
	// sprite do tiro
	if (floor(image_index) == 3) {
		if shoot_held  { //segura
			image_speed = 0;
		} else {	//solta
			image_speed = 1;
			if can_fire {
				
				can_fire=false;
				alarm[SHOOTING] = fire_delay;
				//tem flecha
				if (arrows > 0) {
					//Shoot Arrow	
					//set spawn pos (lado facing e altura)
				//	var ypos = ((sprite_get_height(sprite_index) /2) -2 ) * spawn_pos;
					ypos = -22;
					
					//spawn position
					if down {
						ypos = -8;	
					}
		
					//create arrow
					var inst =0;
					
					inst = instance_create_layer(x+32*facing,y + ypos, LAYER_PROJECTILES, o_player_arrow);
					inst.facing = facing;
		
					//muniçao
					arrows--;
					global.sound_controller.update_event_parameter_and_play_pos(FMOD_EVENT.ATTACK_BOW, FMOD_PARAMETER_NAME_MOVE, FMOD_PARAMETER_ATTACK_BOW_VALUE.RELEASE, x, y);
		
				}else {//sem flecha
					//sound fail			audio_play_sound(snd_arrow_firing,10, false);
				}	
			}
		}
	}
	//repeating shots
	if((image_index >= 7 and shoot) and arrows > 0) {
		image_index = 1;
		can_fire= true;
	}
	
	if (jump and arrows > 0) {
		jumped();
		state = states.SHOOT;
	}	
	//enable smaller jumps
	if ((vsp < 0) and (!jump_held)) {
		vsp = max(vsp,jump_spd*-1/jump_dampner);
	}
	
	
	
	//cancelar tiro
	if attack { 
		state= states.IDLE;
	}
	
	if evade {
		evaded();
	}

	//mudança de estado depois da animação
	if (anim_end()) {
		if (!on_ground()){
			state= states.JUMP;
		}else if down { 
			crouched();
		}else{
			state = states.IDLE;
		}	
	}	
	//caculate movement
	
	collision();
	//check player hp
	check_player_hp();
	//apply animations
	anim();
}
