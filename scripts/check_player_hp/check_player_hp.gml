function check_player_hp() {
	if hp <= 0 {
		
		o_sound_controller.update_event_position_and_play(FMOD_EVENT.DIE,x,y);
		
		var _previous_state = state;
		
		state = states.DIE;
		
		if (_previous_state != state) {
			if (o_player.lives2 >= 1)
			{
				var _ = call_later(3, time_source_units_seconds, function () {
				
					global.options_controller.set_options({
						OPTIONS_PLAYER_LIVES: max(0, o_player.lives2 - 1),
						OPTIONS_PLAYER_DIED: true
					});
				
					instance_destroy(o_player);
				
					player_respawn();
				});
			}
			else 
			{
				global.logger.info("YOU DIED");
				
				global.options_controller.set_options({
					OPTIONS_IS_NEW_GAME: true,
					OPTIONS_PLAYER_DIED: true
				});
				
				var _ = call_later(5, time_source_units_seconds, function () {
					instance_destroy(global.player); 
		
					room_goto(rm_main_menu);	
				});
			}
		}
		
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