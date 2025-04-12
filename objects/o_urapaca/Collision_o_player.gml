with(o_game) {
	has_bow = true;
}

with(o_player) {
	acquire_bow();
	arrows = o_game.max_arrows;
	
	update_save();
}

global.options_controller.set_option(OPTIONS_PLAYER_HAS_BOW, true);

global.options_controller.set_sound_stage(
	SOUND_STAGE_GENERAL, 
	FMOD_EVENT.MUSIC_GAMEPLAY_02,
	"",
	0
);

global.game.quest_step_portugues = max(global.game.quest_step_portugues,4);

repeat(15) {
		var inst = instance_create_depth(x,y, depth, o_spark);
		inst.col_head = c_white;
		inst.col_tail = COLOR_BLUE;
	}

instance_destroy();