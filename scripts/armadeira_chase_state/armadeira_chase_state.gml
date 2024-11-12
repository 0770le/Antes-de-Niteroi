function armadeira_chase_state() {

	image_speed =1;
	
	//calculate target movement
	if alert and !o_player.hurt {
		
		target_x = o_player.x;//previous;
		target_y = o_player.y;//previous;
		
		//stop if player keep distance
		if (abs(x - start_x) > alert_distance*3) {
			state = armadeira_states.ATTACK //IDLE;
			//alarm[HIDING] = hide_delay;
			target_x = x;
			target_y = y;
		}
	//} else {//return to start position if not alert 
	//	target_x = start_x;
	//	target_y = start_y;
	//	//return to idle once at or near start pos
	//	if (abs(x - start_x) < 10) {
	//		state = armadeira_states.IDLE;
	//		alarm[HIDING] = hide_delay;
	//	}
	}

	//calculate movement
	
	var _dir = point_direction(x, y, target_x, target_y);
	var xx = lengthdir_x(chase_spd, _dir);
	var yy = lengthdir_y(chase_spd, _dir); 

	//if knock back, don´t advance
	if ((!hurt) and (alarm[KNOCKEDBACK] < 0 )) {
		//move towards the player
		var buffer = sprite_width  ; //stop flickin left/right when at players x
		if ((abs(x - o_player.x) > buffer)  or (o_player.hp <= 0)) {
			hsp =xx;
		}
	} else {//enemy hurt
		//ensure no vertical movement when knocked back
		vsp =0;
		//slowdown knockback
		hsp = lerp(hsp, 0, drag);
	}

	//sound
	if (!audio_is_playing(snd_bug_chase)) {
		audio_play_sound(snd_bug_chase, 40, false, global.volume);
	}
	
	if (distance_to_object(o_player) < alert_distance*0.45) and !attack  {
	//JUMP		
		y -= 2;
		launch(random_range(3.6,4), random_range(0.9,1.1));
		//launch(4,1.5);
		attack = true;
		attack_cd =  room_speed * random_range(2, 4); 
		alarm[ATTACKING] = attack_cd; 
		state = armadeira_states.JUMP;
		image_index=0;
		image_speed=1;
		if(on_screen(40)) {	audio_play_sound(snd_frog_jump, 40, false, global.volume);}
		
	}

	//escalar if a wall is found
	var t1 = tilemap_get_at_pixel(global.map, side() + sign(hsp), y);
	if (t1 == SOLID) {
		state = armadeira_states.CLIMB;
	}
	
	//not in chse if hsp 0
	if (hsp == 0) { state = armadeira_states.ATTACK;}

	//apply movement
	collision();

}