//show_msg("Aperte o direcional para cima para viajar:\nother.destination", 2);

show_interact_key = true;

var _text = "Deseja viajar para\n";

switch(room) {
	case rm_seregipe:
		_text+= "Morguja Uasu?";
		break;
	case rm_morguja_uasu:
		_text+= "Seregipe?";
		break;
}
	
text_bubble2(id, _text, -1, 4, TEXT_Y_HEIGHT_2l);


if (other.interact and interact) {
	global.sound_controller.update_position_and_play(FMOD_EVENT.TRANSITION_BOAT, x, y);
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
	global.fader.to_room(target_rm, target_x, target_y);
	
	interact = false;
}
