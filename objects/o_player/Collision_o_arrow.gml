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
	
	
	//turning to arrow and knockback
	facing =  other.facing*-1;
	hsp = other.knockback_distance*-facing;	
	
	//process damage
	if player_take_damage {
		if !hurt {
			hurt = true;
			//damage player
			hp -=1;
			//set hurt time
			alarm[HURT] = hurt_time;
			//change state
			state = states.HURTING;
			image_index = 0;

			//screen shake
			scr_screen_shake(.125, -1);
			audio_play_sound(snd_player_hit, 20, false, global.volume);
		} else {
			other.die = true;
		}
	}
} 
