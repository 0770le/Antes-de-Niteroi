with(o_game) {
	has_bow = true;
}

with(o_player) {
	o_camera.y_offset = -80;
	acquire_bow();
	arrows = o_game.max_arrows;
	state = states.BOW_DISPLAY;
	image_index = 0;
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
global.options_controller.set_option(OPTIONS_QUEST_STEP_PORTUGUES, global.game.quest_step_portugues);
global.sound_controller.update_position_and_play(
	FMOD_EVENT.COLLECT_BOW,
	x, y
);

repeat(15) {
		var inst = instance_create_depth(x,y, depth, o_spark);
		inst.col_head = c_white;
		inst.col_tail = COLOR_BLUE;
	}

instance_destroy();