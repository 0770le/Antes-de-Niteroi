function chevalier_aerial_riposte_state(){
	
	
	
	//check state after anim
	if (anim_end()) {
		state = chevalier_states.ENGAGED;
		image_index = 0;
		return
	}	
	


	//create hitboxes during hits index
	if ((image_index >= 2) and (image_index <= 3) and !runned_once)  {
		
		var inst = instance_create_layer(x +1*facing,y, LAYER_INSTANCES, o_enemy_attack_hitbox);
		inst.image_xscale = facing*3.5;
		inst.image_yscale = 3;	
		inst.damage = damage;
		inst.knockback_distance = knockback_distance;
		
		//dust
		runned_once = true;
		alarm[ONCE] = room_speed;
		jump_dust()//faz o objeto dust_evade
	}
	
	//physics
	calc_entity_movement();
	collision();

}