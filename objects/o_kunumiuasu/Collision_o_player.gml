//show_msg("Aperte o direcional para cima para viajar:\nother.destination", 2);

show_interact_key = true;

var _text = "Aperte para cima para viajar\npara ";

switch(room) {
	case rm_cidade_velha:
		_text+= "Akaray";
		break;
	case rm_akaray:
		_text+= "Cidade Velha";
		break;
}
	
text_bubble2(id, _text, -1, 6, TEXT_Y_HEIGHT_2l);


if other.interact {
	global.sound_controller.update_position_and_play(FMOD_EVENT.TRANSITION_BOAT, x, y);
	switch(room) {
		case rm_cidade_velha:
			target_rm = rm_akaray;
			target_x = 2920;
			target_y = 830;
			break;
		case rm_akaray:
			target_rm = rm_cidade_velha;
			target_x = 3720;
			target_y = 415;
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
