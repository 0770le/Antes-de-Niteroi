function harpia_chase_state(){
	
	if(o_player.hp <= 0) {
		facing = sign(o_player.x-x);
		hsp = lerp(hsp,0,0.05);
		x += hsp;
		if(return_timer-- <= 0) {
			state = harpia_states.RETURN;
		
			var move_dir = point_direction(x,y,origin_x,origin_y);
			hsp = 3*dcos(move_dir);
			vsp = -3*dsin(move_dir);
		}
	} else {
		return_timer = return_timer_initial;
		facing = sign(o_player.x-x);
		hsp = clamp(hsp + (dir * acc), -max_spd, max_spd);
		vsp = 0;
	
		if(y > o_player.y - 130) {
			vsp = -1.2;
		} else if (y < o_player.y - 150) {
			vsp = 1.2;	
		}
		
		x += hsp;
		y += vsp;
	
		var _chase_distance = 100;
		if((dir > 0 and x > o_player.x + _chase_distance) or (dir < 0 and x <  o_player.x - _chase_distance)) {
			dir *= -1;	
		}
	
		if(attack_delay-- <= 0 and abs(x - o_player.x) > 50 and abs(hsp) < 1) {
			attack_delay = attack_cooldown;
			attack_prepare_timer = attack_prepare_initial_timer;
			attack_recover_timer = attack_recover_timer_initial;
			attack_hit_ground = false;
			state = harpia_states.ATTACK;
			var attack_dir = point_direction(x,y,o_player.x,o_player.y-20);
			hsp = max_spd*1.5 * dcos(attack_dir);
			vsp = -max_spd*1.5 * dsin(attack_dir);
		}
	}
}