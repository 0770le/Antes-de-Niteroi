with(other) {
	if (can_take_dmg and !hurt) and line_of_sight(true) {
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
			
			o_sound_controller.update_event_position_and_play(hurt_sound_event,x,y);
				
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
		o_sound_controller.update_event_parameter_and_play_pos(FMOD_EVENT.ATTACK_HIT, FMOD_PARAMETER_NAME_MOVE, FMOD_PARAMETER_MOVE_VALUE_ATTACK_HIT.MELEE_HIT,x,y,false);
				
		var inst = instance_create_layer(x, (bbox_top + bbox_bottom)/2, LAYER_EFFECTS, o_player_weapon_hit);
		inst.image_xscale = o_player.facing;
		if (hp <= 0) {
			inst = instance_create_layer(x, (bbox_top + bbox_bottom)/2, LAYER_EFFECTS, o_player_weapon_hit);
			inst.image_xscale = o_player.facing;
			inst.sprite_index = s_sword_hit2;
		}
	}
}