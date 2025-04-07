with(o_game) {
	has_bow = true;
}

with(o_player) {
	acquire_bow();
	arrows = o_game.max_arrows;
	
	update_save();
}

global.options_controller.set_option(OPTIONS_PLAYER_HAS_BOW, true);

instance_destroy();