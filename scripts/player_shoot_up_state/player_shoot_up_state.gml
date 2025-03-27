function player_shoot_up_state() {//o tempo pra dar o tiro é o tempo do sprite
	//get input
	get_input();

	//caculate movement
	calc_movement();
	hsp = 0;
	
	// sprite do tiro
	if (image_index == 3 ) {
		if shoot_held { //segura
			image_speed = 0;
		} else {	//solta
			image_speed = 1;
			if can_fire {
				
				can_fire=false;
				
				//tem flecha
				if (arrows > 0) {
				//Shoot Arrow	
				//set spawn pos (lado facing e altura)
				var ypos = ((sprite_get_height(sprite_index) /2) -2) * spawn_pos;
				ypos = -28;
				//create arrow
				var inst =0;
				//rising arrow
				inst = instance_create_layer(x+32*facing,y + ypos, LAYER_PROJECTILES, o_player_rising_arrow);
				inst.facing = facing;
		
				//muniçao
				arrows--;
	
				//sound
				audio_play_sound(snd_arrow_firing,10, false, global.volume);
		
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