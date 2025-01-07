function tupinamba_melee_attack_state(){
	
	//caculate movement
	calc_entity_movement();
	

	
	hsp = 0;
	
	//check state after anim
	if anim_end() {
		state = tupinamba_melee_states.IDLE;
		image_index = 0;
	}	
	
	
	//paradinha
	var _pause = random_range(0.2,0.6);
	if (floor(image_index) == 2) and !runned_once {	
		runned_once = true;
		alarm[ONCE] = _pause* room_speed;
		anim_paused(_pause);
	
	} 
	
	
	//attacking
	//create hitboxes during hits index
	
	//above
	if image_index >= 3 and image_index <= 4  {
		var inst= instance_create_layer(x -30*facing,y-25, LAYER_INSTANCES, o_enemy_attack_hitbox);
		inst.image_xscale = facing*2;	
		inst.damage = damage;
		inst.knockback_distance = knockback_distance;
	}
	
	//club swing
	if image_index >= 3 and image_index < 7 {
		var inst= instance_create_layer(x +1*facing,y, LAYER_INSTANCES, o_enemy_attack_hitbox);
		inst.image_xscale = facing*1.5;	
		inst.damage = damage;
		inst.knockback_distance = knockback_distance;
		
		hsp+= 3*facing;
		//dust
		if !runned_once {
			runned_once = true;
			alarm[ONCE] = 0.06*room_speed;
			jump_dust()//faz o objeto dust_evade
		}
		
		//hit ground	
		if 	image_index > 4	and !runned_once {	
				runned_once = true;
				attack_delay =  room_speed * random_range(1, 2);
				alarm[ONCE] = attack_delay;	

				//var t1 = tilemap_get_at_pixel(global.map, x+ 65*facing,y+1);
				
				//if t1 != VOID { 
				//	audio_play_sound(snd_enemy_dying, 10, false, global.volume);
				//	scr_screen_shake(0.3,1)	
				//	instance_create_layer(x+ 65*facing,y, LAYER_EFFECTS, o_player_dust_land);
				//}
		}
		
		
		
	}

	//apply movement
	collision();


}