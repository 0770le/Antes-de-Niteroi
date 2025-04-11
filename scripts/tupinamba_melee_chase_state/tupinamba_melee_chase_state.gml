function tupinamba_melee_chase_state() {
	
	//calculate target movement
	
	target_x = o_player.xprevious;
	target_y = o_player.yprevious;
	stare();

	
	//calculate movement
	var _dir = point_direction(x, y, target_x, target_y);
	var xx = lengthdir_x(chase_spd, _dir);
	var yy = lengthdir_y(chase_spd, _dir); 

	//if knock back, don´t advance
	if ((!hurt) and (alarm[KNOCKEDBACK] < 0 )) {
	//move towards the player
		//stop flickin left/right when at players x
		var buffer = attack_range; 
		if ((abs(x - target_x) > buffer) ){
			hsp =xx;
		}else{
		//dont move
			state = tupinamba_melee_states.IDLE;
		}
	} else {
		//enemy hurt
		
		//slowdown knockback
		hsp = lerp(hsp, 0, drag);
	}
	
	//stop if player leaves limited area
	if (x < chase_left_limit or x > chase_right_limit) 
	and (o_player.x < chase_left_limit or o_player.x > chase_right_limit) {
		state = tupinamba_melee_states.IDLE;
	}
	
	//go to idle if not mooving
	if (hsp == 0) {
		state = tupinamba_melee_states.IDLE;
	}
	
	//pula
	// a wall or a void floor is found	
	var t1 = tilemap_get_at_pixel(global.map, side() + sign(hsp) + 12*facing, y);
	//var t2 = tilemap_get_at_pixel(global.map, side() + sign(hsp) + 1*facing, y+30);
	if t1 == SOLID{ // or (t2 == VOID or t2 == DEATH) {
		state =  tupinamba_melee_states.JUMP;
		image_index = 0;
		launch(jump_vsp, jump_hsp);
	}

	if ((o_player.hp > 0) and has_descend) {
		tupi_descend();
		
	}

	//fall	
	if vsp != 0 and !on_ground() {
		state = tupinamba_melee_states.JUMP;
		image_index = 0;
	} 

	calc_entity_movement();
	collision();

}