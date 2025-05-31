show_interact_key = true;

var _text = global.i18n.get_message("tip-travel-to");

switch(room) {
	case rm_seregipe:
		_text+= "Reri'pê?";
		break;
	case rm_reri_pe:
		_text+= "Serigipe?";
		break;
}
	
text_bubble2(id, _text, -1, 4, TEXT_Y_HEIGHT_2l);


if other.interact and interact{
	global.sound_controller.update_position_and_play(FMOD_EVENT.TRANSITION_BOAT, x, y);
	switch(room) {
		case rm_seregipe:
			target_rm = rm_reri_pe;
			target_x = 3815;
			target_y = 1183;
			break;
		case rm_reri_pe:
			target_rm = rm_seregipe;
			target_x = 759;
			target_y = 2991;
			break;
	}
	
	global.fader.to_room(target_rm, target_x, target_y);
	
	interact = false;
}
