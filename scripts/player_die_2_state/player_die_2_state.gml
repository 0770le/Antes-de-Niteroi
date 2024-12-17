
function player_die_2_state(){

	//caculate movement
	calc_entity_movement(global.grav*0.9)
	
	//end of anim
	if image_index >= 2   { 
		//game over
		if (lives <= 0) {
			o_game.game_over_lose = true;
		} else {// continue game
			//restart msg
			show_msg("Aperte Pulo ou ataque para continuar",1);
				//get input
			get_input();
			if (jump or attack) {
				//restart at same room
				fade_to_room(room, room_start_pos_x, room_start_pos_y, room_start_facing, c_black);
				//allow instant camera panning
				with(o_camera) {
					//enable instant panning
					camera_pan_speed = 1;
					alarm[CAMERA_RESET] = 3;
				}
			}
		}	
	} else {// before hitting ground
		//lock in falling sprite
		image_index = 1;
		image_speed = 0;
	}
		
	//once
	if on_ground() and image_index == 1 {
		audio_play_sound(snd_enemy_dying, 5, false, global.volume);
		instance_create_layer(x,y, LAYER_EFFECTS, o_player_dust_land);
	
		//finish animation
		image_index = 2;
		image_speed = 0;
		scale_x= 1;
		scale_y= 1;	
	}
	
	
	//make dust follow corpse while draging
	if on_ground and hsp != 0 {
		if !runned_once {
			runned_once = true;
			alarm[ONCE] = 0.1*room_speed;
			jump_dust()//faz o objeto dust_evade
		}
	}

	//apply movement
	collision();

	//apply animations
	anim();

}