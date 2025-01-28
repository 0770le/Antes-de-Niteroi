
function iaguara_landing_state(){
	if (anim_end()) {
		state =  iaguara_states.IDLE;
		image_index=0;
	}
}