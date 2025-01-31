function check_player_hp() {
	if hp <= 0 {
		
		o_sound_controller.update_event_position_and_play(FMOD_EVENT.DIE,x,y);
		state = states.DIE;
		
		visible = false;
		lives --;
		
		with(instance_create_layer(x,y-3,LAYER_INSTANCES,o_corpse)) {
			sprite_index = s_player_die;
			facing = other.facing;
			other.corpse = id;
		}
		
		with(instance_create_layer (side()+4*facing, y - 22, LAYER_INSTANCES, o_drop)) {
			sprite_index = s_player_weapon;
			bounce = 2;
			facing = other.facing;
		}

	}
	
	if(hp_losing < hp) {
		hp_losing = hp;
	}
	if(hp_losing > hp) {
		hp_losing -= 0.01;	
	}
}