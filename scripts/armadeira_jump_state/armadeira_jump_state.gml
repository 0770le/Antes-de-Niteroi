

function armadeira_jump_state(){
	image_speed = 1;	
	vsp -= grav;
	
	if(vsp < 0)
		image_index = 0;
	else if (image_index >= 2)
		image_index = 2;
	
	if(on_ground()) {
		hsp=0;
		state = armadeira_states.IDLE;
		alarm[HIDING]= hide_delay;
	} 
	
	//apply movement
	calc_entity_movement();
	collision();

}