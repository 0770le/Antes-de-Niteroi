if(timer < 20) {
	saved = true;
} else {
	if(!saved) {
		saved = true;
		o_player.update_save();
	
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
	}
}

if(other.hp <  o_game.max_hp) {
	other.hp = o_game.max_hp;
	global.sound_controller.update_position_and_play(FMOD_EVENT.COLLECT_LIFE_FULL, x, y);
	global.options_controller.set_option(OPTIONS_PLAYER_HP, global.player.hp);
	
	repeat(o_game.gem_sparks) {
		var inst = instance_create_depth(x,y, depth, o_spark);
		inst.col_head = c_white;
		inst.col_tail = c_green;
	}
}
