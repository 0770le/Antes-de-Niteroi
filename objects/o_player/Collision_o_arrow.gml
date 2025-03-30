var player_take_damage = false;

if can_take_dmg {
	player_take_damage = true;
}	
	
if (hp <= 0) {
	player_take_damage = false;
}
	
	
//turning to arrow and knockback
facing =  other.facing*-1;
hsp = other.knockback_distance*-facing;	



//process damage
if player_take_damage {
	var _stuck_arrow  = instance_create_layer(other.x,other.y,other.layer,o_generic_animation);
	_stuck_arrow.sprite_index = s_arrow_stuck;
	_stuck_arrow.image_xscale = other.image_xscale;
	_stuck_arrow.image_angle = other.image_angle;
		
	_stuck_arrow.attached_to = id;
	_stuck_arrow.attach_x_off = x - other.x;
	_stuck_arrow.attach_y_off = y - other.y;
	
	instance_destroy(other);
	if !hurt {
		hurt = true;
		//damage player
		hp -=1;
		instance_create_layer(0,0,LAYER_INSTANCES,o_hp_lost_effect);
		var knockback_dis = 2;
		hsp = other.facing * knockback_dis;
		//set hurt time
		alarm[ALARM_HURTING] = hurt_time;
		//change state
		state = states.HURTING;
		image_index = 0;

		//screen shake
		scr_screen_shake(.125, -1);
		//audio_play_sound(snd_player_hit, 20, false, global.volume);
	}
}
