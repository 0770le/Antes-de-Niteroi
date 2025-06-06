/// @description show message
show_interact_key = true;

if(talk and other.interact) {
	//show_msg(msgs[min(array_length(msgs)-1, quest_step)], 2);
	var _message_index = min(array_length(msgs)-1, quest_step);
	var _text = global.i18n.get_message(msgs[_message_index]);
	var _text_len = string_length(_text);
	
	var _text_x_scale = -1;
	var _text_y_scale = -1;
	
	if(array_length(text_x_scale) > 0) {
		_text_x_scale = text_x_scale[min(array_length(msgs)-1, quest_step)];
	}
	if(array_length(text_y_scale) > 0) {
		_text_y_scale = text_y_scale[min(array_length(msgs)-1, quest_step)];
	}
	
	text_bubble2(id, _text, _text_len * 10, _text_x_scale, _text_y_scale, text_x_offset, text_y_offset);
	quest = false;
	
	global.sound_controller.update_position_and_play(FMOD_EVENT.BUTTON_TALK, x, y);
}
