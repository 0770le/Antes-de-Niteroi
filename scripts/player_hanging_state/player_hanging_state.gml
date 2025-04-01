///descr sliding wall
function player_hanging_state(){
 
	//get input
	get_input();

	//caculate movement
	calc_movement();
	// anulando a gravidade.
	vsp -= global.grav;
	//nova gravidade
	vsp +=  0.06;
	
	if (vsp > 1.8){ vsp =1.8;}
	
	
	//make dust
	if (!instance_exists( o_player_dust_jump)) {
		evade_dust();
	}
	
	// face :na frente e nao chao
	var face = tilemap_get_at_pixel(global.map, side() +1*facing, y-1);
	
	//check state

	//chegou no chão
	if on_ground(){
		o_sound_controller.stop(FMOD_EVENT.HANG);
		state = states.IDLE;
	}
	
	//saiu da parede
	if (face != SOLID) { 
		o_sound_controller.stop(FMOD_EVENT.HANG);
		state = states.JUMP;
	}

	//pular na parede: walljump
	if jump {
		
		facing*=-1;
		hsp = max_hsp *facing;
		o_sound_controller.stop(FMOD_EVENT.HANG);
		jumped(true);
	}

	if evade {
		
		o_sound_controller.stop(FMOD_EVENT.HANG);
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