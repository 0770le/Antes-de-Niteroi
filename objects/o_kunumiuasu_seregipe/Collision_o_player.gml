//show_msg("Aperte o direcional para cima para viajar:\nother.destination", 2);

show_interact_key = true;

var _text = "Aperte para cima para viajar\npara ";

switch(room) {
	case rm_seregipe:
		_text+= "Reri'pê";
		break;
	case rm_reri_pe:
		_text+= "Seregipe";
		break;
}
	
text_bubble2(id, _text, -1, 6, TEXT_Y_HEIGHT_2l);


if other.interact {
	global.sound_controller.play_pos(FMOD_EVENT.TRANSITION_BOAT, x, y);
	switch(room) {
		case rm_seregipe:
			target_rm = rm_reri_pe;
			target_x = 2055;
			target_y = 911;
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
