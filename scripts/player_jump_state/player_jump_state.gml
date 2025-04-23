
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
		
		var _water = false;
		if(layer_exists(LAYER_WATER)) {
			var _water_tile = tilemap_get_at_pixel(layer_tilemap_get_id(LAYER_WATER), bbox_left, bbox_bottom-1);
			_water = _water_tile > 0;
		}
		
		if(_water) {
			emit_water(x,y-4,irandom_range(20,25));
		} else if (vsp > 0.24) {
			instance_create_layer(x,y, LAYER_EFFECTS, o_player_dust_land);
			o_sound_controller.update_event_parameter_and_play_pos(FMOD_EVENT.JUMP, FMOD_PARAMETER_NAME_MOVE, FMOD_PARAMETER_MOVE_JUMP.LAND,x,y);
		}	
		//tocando a parede no ar
	} else if (face == SOLID) and (vsp > 0.24) { // vsp caindo q entra no sliding
			state = states.HANGING;
			//o_sound_controller.update_position_and_play(FMOD_EVENT.HANG,x,y);
			//pro começo do arrastar nao ficar truncado
			vsp += 1; 
	}

	if (attack and can_attack) {
		state = states.AIR_ATTACK;
		image_index =0;
		o_sound_controller.update_event_parameter_and_play_pos(FMOD_EVENT.ATTACK_MELEE, FMOD_PARAMETER_NAME_MOVE, FMOD_PARAMETER_MOVE_VALUE_MELEE_ATTACK.AIR,x,y);
	}
	
 
	if (o_game.has_bow and shoot and arrows > 0) {
		can_fire=true;
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
		vsp = max(vsp, jump_spd*-1/jump_dampner);
	}
	//apply movement
	collision();
	//check player hp
	check_player_hp();
	//apply animations
	anim();
	
}