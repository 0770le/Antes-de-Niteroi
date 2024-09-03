
function player_die_2_state(){

	//caculate movement
	calc_entity_movement()
	
	//didnt use anin_paused() because im using image_speed differently
	
	
	//after lock
	
	
	
	if image_index == 2 {//	image_index >= 1
		//dead player
		if (lives <= 0) {
			o_game.game_over_lose = true;
		} else {
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
	} else {
		//lock in falling sprite
		image_index = 1;
		image_speed = 0;
	}
		
	//once
	if on_ground() and !anim_end() {
		audio_play_sound(snd_enemy_dying, 5, false);
		instance_create_layer(x,y, "Dust", o_player_dust_land);
		//finish animation
		image_index = 2;
		image_speed = 0;
		scale_x=facing;
		scale_y=1;	
	}
	
		
	show_debug_message("image index = " + string(image_index));	
	show_debug_message("image speed = " + string(image_speed));
	show_debug_message("state = " + string(state));
	show_debug_message("runned_once = " + string(runned_once));
	show_debug_message("top" + string( bbox_top));
	show_debug_message("bottom " + string( bbox_bottom));
	show_debug_message("chao (319) " + string( y));
	show_debug_message("---");
	

	//apply movement
	collision();

	//apply animations
	anim();

}