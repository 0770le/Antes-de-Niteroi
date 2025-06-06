
function struck_by_arrow(_dir = facing, _on_fire){
	var take_damage = false;

	//only do if arrow is not set to die
	if (!other.die ) {
		//if can take damage
		if !can_take_dmg {
			take_damage = false;
		} else {
			take_damage = true;
		}	
	
		if (hp <= 0) {
			take_damage = false;
			other.die = true;
		}
	
		//process damage
		if take_damage {
			if !hurt {
				hurt = true;
				//damage
				hp -=1;
				if(_on_fire) {
					hp -=1;
				}
					
				//move away from the hit
				
				alarm[ALARM_HURTING] = hurt_time;
				
				if(arrow_knockback) {
					var knockback_dis = 3;
					hsp = _dir * knockback_dis;
					//set hurt time
					state= enemy_states.HURTING;
				}
				
				o_sound_controller.update_position_and_play(hurt_sound_event,x,y);
				image_index = 0;
				//screen shake
				scr_screen_shake(.125, -1);
				//audio_play_sound(snd_player_hit, 20, false, global.volume);
				other.die = true;
			} else {
				other.die = true;
			}
		}
	} 
}