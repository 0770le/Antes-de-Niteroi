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
	
text_bubble2(id, _text, -1, 5, TEXT_Y_HEIGHT_2l);


if other.interact {
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
