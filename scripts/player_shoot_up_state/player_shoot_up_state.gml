function player_shoot_up_state() {//o tempo pra dar o tiro é o tempo do sprite
	//get input
	get_input();

	//caculate movement
	calc_movement();
	hsp = 0;
	
	// sprite do tiro
	if (floor(image_index) == 3 ) {
		if shoot_held { //segura
			image_speed = 0;
		} else {	//solta
			image_speed = 1;
			if can_fire {
				
				can_fire=false;
				
				//tem flecha
				if (arrows > 0) {
					
					//rising arrow
					var inst = instance_create_layer(x+20*facing,y - 28, LAYER_PROJECTILES, o_player_rising_arrow);
					inst.facing = facing;
		
					//muniçao
					arrows--;
				
					global.sound_controller.update_event_parameter_and_play_pos(FMOD_EVENT.ATTACK_BOW, FMOD_PARAMETER_NAME_MOVE, FMOD_PARAMETER_ATTACK_BOW_VALUE.RELEASE, x, y);
		
				}else {//sem flecha
					//sound fail			audio_play_sound(snd_arrow_firing,10, false);
				}	
			}
		}
	}	//repeating shots
	if(image_index >= 7 and shoot) {
		can_fire= true;
		image_index = 1;
	}
			
	//check state

	if down {
		crouched();
	}
	
	if jump {
		image_speed = 1;
		jumped();
	}	
	//enable smaller jumps
	if ((vsp < 0) and (!jump_held)) {
		vsp = max(vsp,jump_spd*-1/jump_dampner);
	}
	
	if attack { 
		state= states.IDLE;
	}
	
	if evade {
		evaded();
	}

	//mudança de estado depois da animação
	if  (anim_end() ) {
		state = states.IDLE;
	}	
			
	
	//apply movement
	collision();
	//check player hp
	check_player_hp();
	//apply animations
	anim();
}