
function bug_chase_state(){
	//check health
	check_enemy_hp();

	//calculate target movement
	if (o_player.hp > 0) {
		target_x = o_player.xprevious;
		target_y = o_player.yprevious - sprite_get_height(o_player.sprite_index) / 2;
	} else {
		//return to start position if player has died
		target_x = start_x;
		target_y = start_y;
		//return to idle once at or near start pos
		if ((abs(x - start_x) < 2) and (abs(y - start_y))) {
			state = bug_states.IDLE;
		}
	}
	
	//calculate movement
	var _dir = point_direction(x, y, target_x, target_y);
	var xx = lengthdir_x(chase_spd, _dir);
	var yy = lengthdir_y(chase_spd, _dir);

	//if knock back, don´t advance
	if ((hurt) and (alarm[KNOCKEDBACK] < 0 )) {
		//move towards the player
		var buffer = 15; //stop flickin left/right when at players x
		if ((abs(x - o_player.x) > buffer) or (o_player.hp <= 0)) {
			hsp =xx;
		}
		vsp = yy;
	} else {
		//bug hurt
		//ensure no vertical movement when knocked back
		vsp =0;
		//slowdown knockback
		hsp = lerp(hsp, 0, drag);
	}
	
	//facing dir
	if (sign(xx) != 0) {
		facing = sign(xx);
	}

	//sound
	if (!audio_is_playing(snd_bug_chase)) {
		//audio_play_sound(snd_bug_chase, 40, false, global.volume);
	}

	//apply movement
	collision();
	//animations
	bug_anim();
	
	
	
}