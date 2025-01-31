function chevalier_attack_up_state(){
	
	if(anim_end()) {
		attack_up_delay = attack_up_cooldown;
		state = chevalier_states.ENGAGED;
	}
	
	//create hitboxes during hits index
	if ((image_index >= 1) and (image_index < 3) and !runned_once)  {
		
		var inst = instance_create_layer(x+(facing * 30),y-120, LAYER_INSTANCES, o_enemy_attack_hitbox);
		inst.image_xscale = facing;	
		inst.image_yscale = 1;
		
		runned_once = true;
		alarm[ONCE] = 10;
	}
	
	//physics
	calc_entity_movement();
	collision();
	
	
}