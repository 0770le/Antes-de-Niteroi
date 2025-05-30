with(other) {
	if (can_take_dmg and !hurt and !place_meeting(x,y,o_vision_blocker_2)) and line_of_sight2() {
		hurt = true;
		//get sign direction from hitbox to enemy
		var _dir = sign(x - other.x);
			
		//ensure objects are not at the same x
		if (_dir == 0) {
			_dir = 1;
		}
		
					
		if (!unstoppable or other.pierce_unstoppable) {
			//change state
			state = enemy_states.HURTING;
			image_index = 0;
			
			o_sound_controller.update_position_and_play(hurt_sound_event,x,y);
				
			//move away from the hitbox
			hsp = _dir * other.knockback_dis * knockback_multiplier;
		} 
		
		//face the hitbox if on ground
		if (on_ground() and turn_on_damage){
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