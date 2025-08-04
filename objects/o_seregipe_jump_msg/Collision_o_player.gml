if(!global.game.has_cloak) {
	with(other){
		var _text = global.i18n.get_message("tip-find-cloak");
		text_bubble2(id, _text, -1, 6, TEXT_Y_HEIGHT_2l);
	}
}
