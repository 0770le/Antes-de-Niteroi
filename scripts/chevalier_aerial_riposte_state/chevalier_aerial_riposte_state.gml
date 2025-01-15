function chavalier_aerial_riposte_state(){
	
	
	
	//check state after anim
	if (anim_end()) {
		state = chevalier_states.ENGAGED;
		image_index = 0;
	}	
	


	//create hitboxes during hits index
	if ((image_index >= 2) and (image_index <= image_number))  {
		
		var inst = instance_create_layer(x +1*facing,y, LAYER_INSTANCES, o_enemy_attack_hitbox);
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
	}
	
	//physics
	calc_entity_movement();
	collision();

}