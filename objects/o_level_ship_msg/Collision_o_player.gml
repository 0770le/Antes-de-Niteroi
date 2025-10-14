if(active and timer > 60 and (!instance_exists(o_kunumiuasu_parent) or distance_to_object(o_kunumiuasu_parent) > 500)) {
	with(other){
		var _text = global.i18n.get_message("tip-ship");
		text_bubble2(id, _text, -1, 5.3, TEXT_Y_HEIGHT_2l);
	}
	active = false;
}