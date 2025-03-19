function iaguara_chase_state() {
	
	//calculate target movement
	image_speed = 1;
	target_x = o_player.xprevious;
	target_y = o_player.yprevious;
	stare();
	
	//calculate movement
	var _dir = point_direction(x, y, target_x, target_y);
	var xx = lengthdir_x(lerp(chase_spd,abs(hsp), 0.8), _dir);
	var yy = lengthdir_y(chase_spd, _dir); 

	//if knock back, don´t advance
	if ((!hurt) and (alarm[KNOCKEDBACK] < 0 )) {
	//move towards the player
		//stop flickin left/right when at players x
		var buffer = attack_range; 
		if ((abs(x - target_x) > buffer) ){
			hsp =xx;
		}else if(o_player.hp > 0){
			iaguara_attack();
		}
	} else {
		//enemy hurt
		
		//slowdown knockback
		hsp = lerp(hsp, 0, drag);
	}
	
	////stop if player leaves limited area
	//if (x < patrol_left_limit or x > patrol_right_limit) 
	//and (o_player.x < patrol_left_limit or o_player.x > patrol_right_limit) {
	//	state = iaguara_states.IDLE;
	//}
	
	//go to idle if not mooving
	if (hsp == 0 and !alert) {
		state = iaguara_states.IDLE;
		image_index = 0;
	}
	
	if (o_player.hp > 0) {
		descend();
		
	}

	calc_entity_movement();
	collision();

}