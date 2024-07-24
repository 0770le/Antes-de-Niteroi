//cycle through all enemies and see if they were hit
with (o_enemy_parent) {
	if (distance_to_object(other) < 60) {
		if (place_meeting(x,y, other)) {
			if (can_take_dmg) {
				if (hurt == false) {
					hurt = true;
					//get sign direction from hitbox to enemy
					var _dir = sign(x - other.x);
			
					//ensure objects are not at the same x
					if (_dir == 0) {
						_dir = 1;
					}
				
					//move away from the hitbox
					var knockback_dis = 3;
					hsp = _dir * knockback_dis;
			
					//face the hitbox if on ground
					if (on_ground()){
						facing = - _dir;
					}
				
					//damage enemy
					hp -= 1;
				
					//set hurt timer
					alarm[HURT] = hurt_time;
					
					//screnn shake
					scr_screen_shake(.1,1.5);
				
					//sound 
					if (!audio_is_playing(snd_sword_hit)) {
						audio_play_sound(snd_sword_hit, 10, false);
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
}	

//destroy arrows that are hit
var inst = instance_place(x, y, o_arrow); // get the id of object from the collision
if (inst != noone){ //para q só retorne em caso d collisao
	inst.die = true;
}

//enable death at begin step
die = true;


//cod pra bater num enemy só. (em baixo de alarm[HURT])
		//var _create = true;
		//			if (instance_exists(o_sword_hit) == true) {
		//				with(o_sword_hit) {
		//					if (image_index <= 1) {
		//						_create = false;
		//					}
		//				}
		//			}	
					
		//			if (_create == true) {
		//				var inst = instance_create_depth(x, (bbox_top + bbox_bottom)/2, depth -1, o_sword_hit);
		//				inst.image_xscale = o_player.facing;
		//				if (hp <= 0) {
		//					var inst = instance_create_depth(x, (bbox_top + bbox_bottom)/2, depth -1, o_sword_hit);
		//					inst.image_xscale = o_player.facing;
		//					inst.sprite_index = s_sword_hit2;
		//				}
		//			}






