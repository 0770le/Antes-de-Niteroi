//execute state .
if (!instance_exists(o_fade)) {
	script_execute(states_array[state]);
	
	//ensure facing is never 0
	if facing == 0 {facing=1;}
	
	//hide
	if (hidden) {
		image_alpha = lerp (image_alpha, 0.2, 0.1);
	
	} else {
		image_alpha = lerp (image_alpha, 1, 0.1);
	}
	
} else { //com fade
	
	//stop the animation playing
	if (state != states.DIE_2) {
		image_index = 0;
	}
	
	
}