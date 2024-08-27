
function player_die_2_state(){

	//caculate movement
	calc_entity_movement()
	
	if on_ground()and hsp > 0 {
		launch(2, 2,facing*-1)
		audio_play_sound(snd_enemy_dying, 5, false);
	}
	
	//check state
	//animaçao final die2
	if anim_end() {
		image_speed = 0;
			//dead player
			if (lives <= 0) {
				o_game.game_over_lose = true;
			} else {
				//restart msg
				show_msg("Aperte Pulo ou ataque para continuar",1);
					//get input
				get_input();
				if (jump or attack) {
					fade_to_room(room, room_start_pos_x, room_start_pos_y, room_start_facing, c_black);
					//allow instant camera panning
					with(o_camera) {
							//enable instant panning
							camera_pan_speed = 1;
							alarm[CAMERA_RESET] = 3;
					}
				}
			}
	}
	
	//apply movement
	collision();

	//apply animations
	anim();

}