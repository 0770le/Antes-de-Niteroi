function player_shoot_state(){
 
	//get input
	get_input();

	//caculate movement
	calc_movement();
	
	//Shoot Arrow
	if (arrows > 0) {//shooting delay
		if (((image_index >= 1) and (image_index <= 3))) {
			//set spawn transition from the orig
			var ypos = ((sprite_get_height(sprite_index) /2) -2) * spawn_pos;
			
			//create arrow
			var inst = instance_create_layer(x,y + ypos, "Arrow_shoot", o_arrow);
			inst.facing = facing;
		
			
			var inst = instance_create_layer (side(), y + ypos, "Arrow_shoot", o_arrow_spark);
			inst.image_xscale = facing;
		
			//muniçao
			arrows--;
	
			//sound
			audio_play_sound(snd_arrow_firing,10, false);		
		}
	}
	
	//check state
	
	if down {
		crouched();
	}
	
	if evade {
		state=states.EVADE;
	}
	
	if (image_index >= (image_number - sprite_get_speed(sprite_index)/room_speed)) {
		if (!on_ground()){
			state= states.JUMP
		}else{
			if (hsp != 0) { 
				state= states.WALK; 
			}else{
				state = states.IDLE;
			}
		}
	}	
	
	if jump {
		jumped();
		state = states.SHOOT;
	}

		
	
	//enable smaller jumps
	if ((vsp < 0) and (!jump_held)) {
		vsp = max(vsp,jump_spd/jump_dampner);
	}
	
	//apply movement
	collision();
	//check player hp
	check_player_hp();
	//apply animations
	anim();
}