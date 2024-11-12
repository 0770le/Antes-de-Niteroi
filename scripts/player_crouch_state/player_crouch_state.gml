
function player_crouch_state(){
	//get input
	get_input();
	
	//calculate movement
	calc_movement();
	
	//check state
	if down {
		state = states.CROUCH;
		hsp=0;
	} else {
		state = states.IDLE;
	}
		
	if (alarm[HIDING] == 0) {
		hide_check() 
	} 
	
	if (hsp != 0) {
		state = states.WALK;
	}
	
	if attack {
		state = states.ATTACK;
		image_index = 0;
	}
	
	if (shoot and arrows > 0) {
		state = states.SHOOT;
		image_index = 0;
	}
	
	if evade {
		evaded();
	} 
	
	//allow player descend on plataforms
	var vt1 = tilemap_get_at_pixel(global.map, bbox_left, bbox_bottom +1);
	var vt2 = tilemap_get_at_pixel(global.map, bbox_right, bbox_bottom +1);
	
	if jump and (vt1 == PLATAFORM or vt2 == PLATAFORM){
		state = states.JUMP;
		y += 1;
	}
	
	
	
	//apply movement
	collision();
	//check player hp
	check_player_hp();
	//aply animation
	anim();
}
