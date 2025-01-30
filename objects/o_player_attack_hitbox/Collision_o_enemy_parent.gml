with(other) {
	if (can_take_dmg and !hurt) and line_of_sight() {
		hurt = true;
		//get sign direction from hitbox to enemy
		var _dir = sign(x - other.x);
			
		//ensure objects are not at the same x
		if (_dir == 0) {
			_dir = 1;
		}
		
					
		if (!unstoppable) {
			//change state
			state = enemy_states.HURTING;
			image_index = 0;
				
			var knockback_dis = 8;
			//move away from the hitbox
			hsp = _dir * knockback_dis;
		} 
		
		//face the hitbox if on ground
		if (on_ground()){
			facing = -_dir;
		}
				
		//damage enemy
		hp -= 1;
				
		//set hurt timer
		alarm[ALARM_HURTING] = hurt_time;
					
		//screnn shake
		scr_screen_shake(.1,1.5);
				
		//sound 
		if (!audio_is_playing(snd_sword_hit)) {
			audio_play_sound(snd_sword_hit, 10, false, global.volume);
		}
				
		var inst = instance_create_layer(x, (bbox_top + bbox_bottom)/2, LAYER_EFFECTS, o_player_weapon_hit);
		inst.image_xscale = o_player.facing;
		if (hp <= 0) {
			inst = instance_create_layer(x, (bbox_top + bbox_bottom)/2, LAYER_EFFECTS, o_player_weapon_hit);
			inst.image_xscale = o_player.facing;
			inst.sprite_index = s_sword_hit2;
		}
	}
}