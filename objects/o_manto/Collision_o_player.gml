if(!o_game.has_cloak) {
	global.player.update_save();
	o_game.has_cloak = true;
	image_index = 1;

	global.options_controller.set_option(OPTIONS_PLAYER_HAS_CAPE, true);
}
