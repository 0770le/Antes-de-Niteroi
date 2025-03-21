
function iaguara_landing_state(){
	vsp = 0;
	hsp = 0;
	if (anim_end()) {
		state =  iaguara_states.IDLE;
		image_index=0;
	}
}