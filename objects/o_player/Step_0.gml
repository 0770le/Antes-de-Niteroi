//execute state .
if (!instance_exists(o_fade)) {
	script_execute(states_array[state]);
} else { //player existe
	//stop the animation playing
	if (state != states.DIE) {
		image_index = 0;
	}
	
	//hide
	if (hidden) {
		image_alpha = lerp (image_alpha, 0.2, 0.1);
	
	} else {
		image_alpha = lerp (image_alpha, 1, 0.1);
	}
	
}