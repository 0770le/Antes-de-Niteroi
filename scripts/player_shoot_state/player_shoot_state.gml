function player_shoot_state() {//o tempo pra dar o tiro é o tempo do sprite
	//get input
	get_input();

	//caculate movement
	calc_movement();
		
	// sprite do tiro
	if (image_index == 6 ) {
		if shoot_held { //segura
			image_speed = 0;
		} else {	//solta
			if can_fire {
				image_speed = 1;
				can_fire=false;
				alarm[SHOOTING] = fire_delay;
				//tem flecha
				if (arrows > 0) {
					//Shoot Arrow	
					//set spawn pos (lado facing e altura)
					var ypos = ((sprite_get_height(sprite_index) /2) -2) * spawn_pos;
					ypos = -20;
			
					if down {
						ypos = -10;	
					}
		
					//create arrow
					var inst =0;
					//rising arrow
					if up and on_ground(){
						inst = instance_create_layer(x,y + ypos, "Arrow_shoot", o_player_rising_arrow);
					} else {
						inst = instance_create_layer(x,y + ypos, "Arrow_shoot", o_player_arrow);
					}
		
					inst.facing = facing;				
			
					inst = instance_create_layer (side(), y + ypos, "Arrow_shoot", o_arrow_spark);
					inst.image_xscale = facing;
		
					//muniçao
					arrows--;
	
					//sound
					audio_play_sound(snd_arrow_firing,10, false);
		
				}else {//sem flecha
					//sound fail			audio_play_sound(snd_arrow_firing,10, false);
				}	
			}
		}
	}
	//repeating shots
	if(image_index >= 9 and shoot) {
		image_index = 3;
	}
	//check state

	if down {
		var _temp = image_index;
		crouched();
		state = states.SHOOT;
		image_index = _temp;
	}
	
	if jump {
		jumped();
		state = states.SHOOT;
	}	
	//enable smaller jumps
	if ((vsp < 0) and (!jump_held)) {
		vsp = max(vsp,jump_spd/jump_dampner);
	}
	
	//nao andar no chao
	if on_ground() {
		hsp=0;
	}	
	
	//cancelar tiro
	if attack { 
		state= states.IDLE;
	}
	
	if evade {
		evaded();
	}

	//mudança de estado depois da animação
	if anim_end() {
		if (!on_ground()){
			state= states.JUMP;
		}else if down { 
			state= states.CROUCH; 
		}else{
			state = states.IDLE;
		}	
	}	
	
	//apply movement
	collision();
	//check player hp
	check_player_hp();
	//apply animations
	anim();
}
