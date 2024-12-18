if(saving and !saved) {
	if(sprite_index != s_barqueiro_libertando) {
		sprite_index = s_barqueiro_libertando;
		image_index = 0;
	} else {
		if(anim_end()) {
			saved = true;
			o_portugues.quest_step++;
			o_portugues.quest = true;
		}
	}
}

if(saved and !released){
	sprite_index = s_barqueiro_liberto;
	talk = true;
}