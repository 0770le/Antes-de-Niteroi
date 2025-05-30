
function bug_patrol_state(){

	//set spd
	hsp = spd * facing;
	vsp = 0;
	
	//change state
	if (abs(start_x - x) > patrol_dis) {
		state = bug_states.IDLE;
	}
	
	//turn around if a wall is found
	if facing {
		var _side = bbox_right;
	} else {
		var _side = bbox_left;
	}
	var t1 = tilemap_get_at_pixel(global.map, _side + sign(hsp), y);
	if (t1 == SOLID) {
		state = bug_states.IDLE;
	} 
	
	//chase
	if ((distance_to_object(o_player) < chase_distance) and (o_player.hp > 0)) {
		state = bug_states.CHASE;
		//audio_play_sound(snd_bug_sees_player, 40, false, global.volume);
	}
	
	//apply movement
	collision();
	//animations
	bug_anim();
	
	
	
}