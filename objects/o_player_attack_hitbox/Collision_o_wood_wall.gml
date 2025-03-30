with (other) {
	if (distance_to_object(other) < 60) {
		if (place_meeting(x,y, other)) {
				if !hurt {
					hurt = true;
					//get sign direction from hitbox to enemy
					var _dir = sign(x - other.x);
			
					//ensure objects are not at the same x
					if (_dir == 0) {
						_dir = 1;
					}
				
					//damage 
					hp -= 1;
				
					//set hurt timer
					alarm[ALARM_HURTING] = hurt_time;
					
					//screnn shake
					scr_screen_shake(.1,1.5);
				
					//sound 
					if (!audio_is_playing(snd_sword_hit)) {
						//audio_play_sound(snd_sword_hit, 10, false, global.volume);
					}
				
					var inst = instance_create_depth(x, (bbox_top + bbox_bottom)/2, depth -1, o_player_weapon_hit);
					inst.image_xscale = o_player.facing;
					if (hp <= 0) {
						var inst = instance_create_depth(x, (bbox_top + bbox_bottom)/2, depth -1, o_player_weapon_hit);
						inst.image_xscale = o_player.facing;
						inst.sprite_index = s_sword_hit2;
					}
				}
			
		}	
	}
}	