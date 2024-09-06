var player_take_damage = false;

//only run if arrow is not set to die
if (!other.die ) {
	if can_take_dmg {
		player_take_damage = true;
	}	
	
	if (hp <= 0) {
		player_take_damage = false;
		other.die = true;
	}
	
	//process damage
	if player_take_damage {
		if !hurt {
			hurt = true;
			//damage player
			hp -=1;
			//set hurt time
			alarm[HURT] = hurt_time;
			//screen shake
			scr_screen_shake(.125, -1);
			audio_play_sound(snd_player_hit, 20, false);
		} else {
			other.die = true;
		}
	}
} 