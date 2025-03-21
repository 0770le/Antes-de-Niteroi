function player_attack_walk_state(){
	//get input
	get_input();
	
	if(image_index < 2 or image_index > 3) {
		if jump {
			jumped();
			return;
		}
		if down {
			crouched();
			return;
		}
	}
	
	//caculate movement
	if (image_index <= 2 ) {
		calc_movement();
	} else {//others attacks cant change direction
		calc_entity_movement();
	}
	
	//check state after anim
	if anim_end() {
		state = states.IDLE;
	}	
	if evade {
		state = states.EVADE;
		
	}	
	
	//attacking
	//create hitboxes during hits index
	if image_index >= 2 and image_index <=4 {
		var inst= instance_create_layer(side(),y -10, LAYER_INSTANCES, o_player_attack_hitbox);
		inst.image_xscale = facing*0.8;	
		inst.image_yscale *= 0.7;
		inst.knockback_dis = 12;
		inst.pierce_unstoppable = true;
		//impulso
		hsp = lerp(abs(hsp), max_hsp,0.3)*facing ;
	}
	
	//apply movement
	collision();
	//check player hp
	check_player_hp();
	//apply animations
	anim();

}