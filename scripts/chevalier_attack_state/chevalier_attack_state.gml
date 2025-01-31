function chevalier_attack_state(){
	
	if(aerial_riposte()) {
		return;	
	}

	//check state after anim
	if (anim_end()) {
		state = chevalier_states.ENGAGED;
		image_index = 0;
	}

	//create hitboxes during hits index
	if ((image_index >= 9) and (image_index < 10) and !runned_once)  {
		
		var inst = instance_create_layer(x +1*facing,y, LAYER_INSTANCES, o_enemy_attack_hitbox);
		inst.image_xscale = facing*1.5;	
		inst.damage = damage;
		inst.knockback_distance = knockback_distance;
		
		hsp+= 6*facing;
		runned_once = true;
		alarm[ONCE] = 10;
		jump_dust()//faz o objeto dust_evade
	}
	
	//physics
	calc_entity_movement();
	collision();

}