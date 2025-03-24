//show_msg("Aperte o direcional para cima para viajar:\nother.destination", 2);

show_interact_key = true;

var _text = "Aperte para cima para viajar\npara ";

switch(room) {
	case rm_seregipe:
		_text+= "Morguja Uasu";
		break;
	case rm_morguja_uasu:
		_text+= "Seregipe";
		break;
}
	
text_bubble2(id, _text, -1, 6, TEXT_Y_HEIGHT_2l);


if other.interact {
	switch(room) {
		case rm_seregipe:
			target_rm = rm_morguja_uasu;
			target_x = 4460;
			target_y = 1246;
			break;
		case rm_morguja_uasu:
			target_rm = rm_seregipe;
			target_x = 7040;
			target_y = 2990;
			break;
	}
	
	fade_to_room(target_rm, target_x, target_y, other.facing, c_black);
}
