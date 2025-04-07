show_interact_key = true;

var _text = "Deseja viajar para\n";

switch(room) {
	case rm_seregipe:
		_text+= "Reri'pê?";
		break;
	case rm_reri_pe:
		_text+= "Seregipe?";
		break;
}
	
text_bubble2(id, _text, -1, 5, TEXT_Y_HEIGHT_2l);


if other.interact {
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
	var _aux = {
		rm: target_rm,
		x: target_x,
		y: target_y,
		facing: other.facing,
		callback: function () {
			fade_to_room(self.rm, self.x, self.y, self.facing, c_black);		
		}
	}
	var _ = call_later(2, time_source_units_seconds, _aux.callback);
}
