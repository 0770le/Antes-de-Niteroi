

function armadeira_jump_state(){
	
	vsp -= global.grav*0.5;
	
	if(on_ground()) {
		hsp=0;
		state = armadeira_states.IDLE;
		alarm[HIDING]= hide_delay;
	} 
	
	//apply movement
	collision();

}