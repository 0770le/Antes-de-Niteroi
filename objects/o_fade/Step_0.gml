if (fade_to_colour == true) {
	alpha += fade_spd;
	if (alpha >= 1) {
		fade_to_colour = false;
		with(o_player) {
			//set starting position
			room_start_pos_x = other.target_x;
			room_start_pos_y = other.target_y;
			x = room_start_pos_x;
			y = room_start_pos_y;
			
			//set facing direction
			room_start_facing = other.facing;
			facing = room_start_facing;
			
			//reset values
			hsp = 0;
			csp = 0;
			hsp_decimal = 0;
			vsp_decimal = 0;
			scale_x = 1;
			scale_y = 1;
			
			//reset player if dead
			if (state == states.DIE_2) {
				image_speed = 1;
				hp = o_game.max_hp;
			}
			
			//ensure we stay in game_end_state
			if (state != states.GAME_END) {
				//change start and update animation
				state = states.IDLE;
				anim();				
			}
		}
		//pan camera quickly
		o_camera.camera_pan_speed = 1;
		room_goto(target_rm);
	}
} else {
	//fade from colour (terminando fade)
	alpha -= fade_spd;
	if (alpha <= 0) {
		//reset camera pan speed
		o_camera.camera_pan_speed = o_camera.camera_pan_speed_initial;
		instance_destroy();
	}
}