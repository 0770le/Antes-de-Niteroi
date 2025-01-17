function harpia_attack_recover_state(){
	vsp -= 0.02;
	x += hsp;
	y += vsp;
	if(vsp < -1) {
		state = harpia_states.CHASE;	
	}
}