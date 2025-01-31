function chevalier_chase_state() {
	
	turn();
	if(aerial_riposte()) {
		return;	
	}
	
	if(attack_up()) {
		return;
	}
	
	//calculate target movement
	target_x = o_player.xprevious;
	target_y = o_player.yprevious;
		
	//calculate movement
	var _dir = point_direction(x, y, target_x, target_y);
	var xx = lengthdir_x(chase_spd, _dir);
	var yy = lengthdir_y(chase_spd, _dir); 

	//if knock back, don´t advance
	if ((!hurt) and (alarm[KNOCKEDBACK] < 0 )) {
	//move towards the player
		//player reached
		//stop flickin left/right when at players x
		var buffer = attack_range; 
		if ((abs(x - target_x) > buffer) ){
			hsp =xx;
		}else{
		//dont move
			state = chevalier_states.ENGAGED;
		}
	} else {
		//enemy hurt
		
		//slowdown knockback
		hsp = lerp(hsp, 0, drag);
	}
	
	//stop if player leaves limited area
	if (o_player.hp <= 0
	or (x < patrol_left_limit or x > patrol_right_limit) 
	and (o_player.x < patrol_left_limit or o_player.x > patrol_right_limit)) {
		state =  chevalier_states.ENGAGED;
	}
	
	//go to idle if not mooving
	if hsp == 0 {
		state =  chevalier_states.ENGAGED;
	}
	
	//physics
	calc_entity_movement();
	collision();

}