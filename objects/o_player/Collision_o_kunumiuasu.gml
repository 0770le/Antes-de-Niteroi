
//show_msg 
show_msg("Aperte o direcional para cima para viajar: + destination", 2);
	
if up {
	with(other){
		if !runned_once {
			fade_to_room(target_rm, target_x, target_y, other.facing, c_black);
			runned_once = true;
		}
	}	
}
