///on wall
function tupinamba_melee_hanging_state(){
	
	//caculate movement
	calc_entity_movement();
	// anulando a gravidade.
	vsp -= global.grav;
	//nova gravidade
	vsp +=  0.06; 
	
	hsp = 0;
	
	//make dust
	if (!instance_exists( o_player_dust_jump)) {
		evade_dust();
	}
	
	// face :na frente e nao chao
	var face = tilemap_get_at_pixel(global.map, side() +1*facing, y-1);
	
	
	
	//wall jump 
	if hanging_time-- <= 0 { 
		launch(jump_vsp,jump_hsp, facing*-1);
		state = tupinamba_melee_states.JUMP;
		evade_dust();
		//audio_play_sound(snd_jump, 15, false, global.volume);
	}
	
	//apply movement
	collision();


}