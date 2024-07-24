function armadeira_chase_state() {
	hidden = false;
	
	//voltar a dar o pulo
	if (can_attack) {
		state = armadeira_states.IDLE;
		alarm[HIDING] = hide_delay;
	}
	//calculate target movement

	if alert {
		target_x = o_player.xprevious;
		target_y = o_player.yprevious - sprite_get_height(o_player.sprite_index) / 2;
			//stop if player keep distance
		if (abs(x - start_x) > alert_distance) {
			state = armadeira_states.IDLE;
			alarm[HIDING] = hide_delay;
		}
	} else {
		//return to start position if not alert 
		target_x = start_x;
		target_y = start_y;
		//return to idle once at or near start pos
		if (abs(x - start_x) < 4) {
			state = armadeira_states.IDLE;
			alarm[HIDING] = hiding_delay;
		}
	}

	//calculate movement
	var _dir = point_direction(x, y, target_x, target_y);
	var xx = lengthdir_x(chase_spd, _dir);
	var yy = lengthdir_y(chase_spd, _dir); 

	//if knock back, don´t advance
	if ((!hurt) and (alarm[KNOCKEDBACK] < 0 )) {
		//move towards the player
		var buffer = 15; //stop flickin left/right when at players x
		if ((abs(x - o_player.x) > buffer) or (o_player.hp <= 0)) {
			
			hsp =xx;
		}
	} else {
		//enemy hurt
		//ensure no vertical movement when knocked back
		vsp =0;
		//slowdown knockback
		hsp = lerp(hsp, 0, drag);
	}

	//sound
	if (!audio_is_playing(snd_bug_chase)) {
		audio_play_sound(snd_bug_chase, 40, false);
	}
	

	////escalar if a wall is found

	var t1 = tilemap_get_at_pixel(global.map, side() + sign(hsp), y);
	if (t1 == SOLID) {
		state = armadeira_states.CLIMB;
	}
	
	
	//apply movement
	collision();

}