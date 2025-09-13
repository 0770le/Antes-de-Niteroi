if(!o_game.quest_saved_kunumiuasu and place_meeting(x,y,o_stake)) {
	with(other){
		alarm[8] = 30;
		interact_key_array = [INPUT_IN_GAME_ACTION.ATTACK];
	}
}