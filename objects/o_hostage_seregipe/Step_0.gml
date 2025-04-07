if(saving and !saved) {
	if(sprite_index != s_barqueiro_libertando) {
		sprite_index = s_barqueiro_libertando;
		image_index = 0;
	} else {
		if(anim_end()) {
			saved = true;
			quest = true;
			o_game.quest_saved_kunumiuasu_seregipe = true;
		}
	}
}

if(saved){
	sprite_index = s_barqueiro_liberto;
	talk = true;
}

if((saved or saving) and !on_screen(20)) {
	quest_complete_kunumiuasu_seregipe();
}