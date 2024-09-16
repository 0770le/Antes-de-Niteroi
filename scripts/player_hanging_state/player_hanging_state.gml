///descr sliding wall
function player_hanging_state(){
 
	//get input
	get_input();

	//caculate movement
	//vsp entra do jump state /0.24
	//global.grav == 0.25 caindo. em o_game
	calc_movement();
	// anulando a gravidade.
	vsp -= global.grav;
	//nova gravidade
	vsp +=  0.06; 
	
	//make dust
	if (!instance_exists( o_player_dust_jump)) {
		evade_dust();
	}
	
	// face :na frente e nao chao
	var face = tilemap_get_at_pixel(global.map, side() +1*facing, y-1);
	
	//check state

	//chegou no chão
	if on_ground(){
		state = states.IDLE;
	}
	
	//saiu da parede
	if (face != SOLID) { 
			state = states.JUMP;
	}

	//pular na parede: walljump
	if jump {
		evade_dust();
		facing*=-1;
		scale_x = scale_min;
		scale_y = scale_max;
		vsp_decimal = 0;
		state = states.JUMP;
		hsp = max_hsp *facing;
		vsp = jump_spd;
		audio_play_sound(snd_jump, 15, false, global.volume);
	}

	if evade {
		evaded();
		image_index = 0;
	}
	
	//apply movement
	collision();

	//check player hp
	check_player_hp();
	
	//apply animations
	anim();

}