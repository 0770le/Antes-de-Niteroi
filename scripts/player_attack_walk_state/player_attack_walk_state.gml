function player_attack_walk_state(){
	//get input
	get_input();
	
	//caculate movement
	if (image_index <= 3 ) {
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
	if floor(image_index) == 4 {
		var inst= instance_create_layer(x,y, "Player", o_player_attack_hitbox);
		inst.image_xscale = facing*0.7;	
	}
	
	//apply movement
	collision();
	//check player hp
	check_player_hp();
	//apply animations
	anim();

}