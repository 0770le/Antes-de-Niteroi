/// @desc check if can hide
function hide_check() {
	if (((hide_ready) and (hide_cover)) and (!engaged)) { 
		state= states.HIDE;
		image_index = 0;
	}
}	
	
