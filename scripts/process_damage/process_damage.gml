// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function process_damage(_damage){
	if ((o_player.hp > 0) and  (!hurt)) and can_take_dmg {
		hurt = true;

		scale_x = scale_max;
		scale_y = scale_min;
			
		hp-= _damage;
				
		//set hurt timer
		alarm[ALARM_HURTING] = hurt_time;	
		
		//change state
		state = states.HURTING;
		image_index = 0;
			
		o_sound_controller.update_position_and_play(FMOD_EVENT.HURT, x, y);
			
		//screnn shake
		scr_screen_shake(.125,1);
	}	
}