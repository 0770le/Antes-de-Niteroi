
function frog_attack_state(){
	//check health
	check_enemy_hp();
	//get inputs

	//caculate movement
	calc_entity_movement();
	
	//modify state
	//attack warning
	if ((image_index == 2) and (!inhale)) {
		inhale = true;
		alarm[ATTACKING] =inhale_timer; // inhale_timer é o meu attack_delay e attack_delay é o meu CD 
		image_speed = 0;
	}
	
	
	if attack{
		if ((image_index >= 5) and (image_index <=6)) {
			//create the hitbox
			var inst = instance_create_layer(x,y,"Enemy",o_enemy_attack_hitbox);
			//ensure hitbox faces the way the froh that created it is facing
			inst.image_xscale= facing;
			if (image_index == 5) {
				audio_play_sound(snd_frog_attack, 15, false);
			}
		}
		
		//set tongue depth, coloca o inimigo na frente do player
		depth = layer_get_depth(layer_get_id("Player")) -1;
	
		if ((image_index) >= (image_number - sprite_get_speed(sprite_index)/room_speed)) {
			state = frog_states.IDLE;
			alarm[CAN_ATTACK] = attack_delay;
			depth = layer_get_depth(layer_get_id("Enemy"));
			inhale = false;
			attack = false;
		} 
	}
	
	//apply movement
	collision();
	//animations
	frog_anim();
	
}