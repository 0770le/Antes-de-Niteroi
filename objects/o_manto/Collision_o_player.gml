if(!o_game.has_cloak) {
	global.player.update_save();
	o_game.has_cloak = true;
	image_index = 1;

	global.options_controller.set_option(OPTIONS_PLAYER_HAS_CAPE, true);
	
	repeat(15) {
		var inst = instance_create_depth(x,y, depth, o_spark);
		inst.col_head = c_white;
		inst.col_tail = c_red;
	}
	
	
	global.game.quest_step_portugues = max(global.game.quest_step_portugues,5);
}
