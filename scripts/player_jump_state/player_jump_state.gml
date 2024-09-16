
function player_jump_state(){
  
	//get input
	get_input();

	//caculate movement
	calc_movement();
	
	//na frente e nao chao
	var face = tilemap_get_at_pixel(global.map, side() +1*facing, y-1);
	
	//check state
	if on_ground() {
		//apply strech
		scale_x = scale_max;
		scale_y = scale_min;
		if (hsp != 0) {
			state = states.WALK;
		} else {
			state = states.IDLE;
		}
		//create dust if landing
		if (vsp > 0) {
			instance_create_layer(x,y, "Dust", o_player_dust_land);
			audio_play_sound(snd_landing, 20, false, global.volume);
		}	
		//tocando a parede no ar
	} else if (face == SOLID) and (vsp > 0.24) { // vsp caindo q entra no sliding
			state = states.HANGING;
			//pro começo do arrastar nao ficar truncado
			vsp += 1; 
	}

	if attack {
		state = states.AIR_ATTACK;
		image_index =0;
		can_attack = false;
		alarm[ATTACKING]= attack_delay;
	}
	
	if shoot {
		state = states.SHOOT;
		image_index = 0;
	}
	
	//enable double jumps
	if jump {
		jumped();
	}
	
	// permite gastar um pulo com evade no ar
	if ((evade and o_game.has_cloak) and (has_evade)) {
		evaded();
		jumps--;
	}
	
	
	//enable smaller jumps
	if ((vsp < 0) and (jump_held == false)) {
		vsp = max(vsp, jump_spd/jump_dampner);
	}
	//apply movement
	collision();
	//check player hp
	check_player_hp();
	//apply animations
	anim();
	
}