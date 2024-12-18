show_msg("Aperte o direcional para cima para viajar:\nother.destination", 2);

if other.up {
	switch(room) {
		case rm_cidade_velha:
			target_rm = rm_akaray;
			target_x = 2920;
			target_y = 751;
			break;
		case rm_akaray:
			target_rm = rm_cidade_velha;
			target_x = 3720;
			target_y = 415;
			break;
	}
	
	fade_to_room(target_rm, target_x, target_y, other.facing, c_black);
}
