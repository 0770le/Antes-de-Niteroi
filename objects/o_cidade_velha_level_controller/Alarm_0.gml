/// @description initialize room

if(o_game.quest_saved_kunumiuasu) {
	quest_complete_kunumiuasu();	
} else {
	with(o_portugues) {
		o_portugues.quest_step = 0;
		global.game.quest_step_portugues = 0;
		global.options_controller.set_option(OPTIONS_QUEST_STEP_PORTUGUES, global.game.quest_step_portugues);
	}
}