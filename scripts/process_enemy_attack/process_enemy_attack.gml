function process_enemy_attack() { // (hk, bk) {
///@desc process_enemy_attack(hurt_knockback, block_knockback)
///@arg hurt_knockback_def_-1
///@arg block_knockback_def_-1
	
	if ((o_player.hp > 0) and  (!hurt)) and can_take_dmg {
			hurt = true;

			//facing the enemy
			facing = sign(other.xprevious - x);
		

		
			//move away 

			scale_x = scale_max;
			scale_y = scale_min;
			vsp_decimal = 0;
			hsp_decimal = 0;		
			
			hsp = other.knockback_distance*-facing;
			
			//damage no  hp do player
			repeat(other.damage) {
				hp--;
			}
				
			//set hurt timer
			alarm[ALARM_HURTING] = hurt_time;	
		
			//change state
			state = states.HURTING;
			image_index = 0;
			
			o_sound_controller.update_position_and_play(FMOD_EVENT.HURT, x, y);
			
			//screnn shake
			scr_screen_shake(.125,1);
			
			//sound
			//audio_play_sound(snd_player_hit, 40, false, global.volume);
	}	
}	
