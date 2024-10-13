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
	if (floor(image_index) == 5 and !runned_once) {
		if shoot_held { //segura
			image_speed = 0;
			runned_once = true;
			alarm[ONCE]= room_speed *0.2;
		} else {	//solta
			if can_fire {
				image_speed = 1;
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

					inst = instance_create_layer(x+32*facing,y + ypos, "Arrow_shoot", o_player_arrow);
					inst.facing = facing;				
					inst = instance_create_layer (side(), y + ypos, "Arrow_shoot", o_arrow_spark);
					inst.image_xscale = facing;
		
					//muniçao
					arrows--;
	
					//sound
					audio_play_sound(snd_arrow_firing,10, false, global.volume);
		
				}else {//sem flecha
					//sound fail			audio_play_sound(snd_arrow_firing,10, false);
				}	
			}
		}
	}
	//repeating shots
	if(image_index >= 11 and shoot) {
		image_index = 3;
	}
	//check state

	if down { //allow continuing shooting fluidity 
		var _index_holder = image_index;
		var _speed_holder = image_speed;
		crouched();
		state = states.SHOOT;
		image_index = _index_holder;
		image_speed = _speed_holder;
	}
	
	if jump {
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
	if anim_end() {
		if (!on_ground()){
			state= states.JUMP;
		}else if down { 
			state= states.CROUCH; 
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
