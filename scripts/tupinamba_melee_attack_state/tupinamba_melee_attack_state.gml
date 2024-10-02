function tupinamba_melee_attack_state(){
	
	//caculate movement
		calc_entity_movement();
	
	hsp = 0;
	
	//check state after anim
	if floor(image_index) == 10 { //anim_end() {
		state = tupinamba_melee_states.IDLE;
	}	
	
	
	////paradinha
	//var _pause = random(1);
	//if (floor(image_index) == 2) and !runned_once {	
	//	runned_once = true;
	//	alarm[ONCE] = _pause* room_speed;
	//	anim_paused(_pause);
	//} 
	
	
	//attacking
	//create hitboxes during hits index
	
	//above
	if image_index >= 3 and image_index <= 4  {
		var inst= instance_create_layer(x -30*facing,y-25, "Player", o_enemy_attack_hitbox);
		inst.image_xscale = facing*2;	
		inst.damage = damage;
		inst.knockback_distance = knockback_distance;
	}
	
	//club
	if image_index >= 3 and image_index < 7 {
		var inst= instance_create_layer(x +1*facing,y, "Player", o_enemy_attack_hitbox);
		inst.image_xscale = facing*1.5;	
		inst.damage = damage;
		inst.knockback_distance = knockback_distance;
		
		//hit ground	
		if 	image_index > 4	and !runned_once {	
				runned_once = true;
				alarm[ONCE] = attack_delay;	

				var t1 = tilemap_get_at_pixel(global.map, x+ 65*facing,y+1);
				
				if t1 != VOID { 
					audio_play_sound(snd_enemy_dying, 10, false, global.volume);
					scr_screen_shake(0.3,1)	
					instance_create_layer(x+ 65*facing,y, "Dust", o_player_dust_land);
				}
		}
	}
	
	//apply movement
	collision();
	//apply animations
	anim();

}