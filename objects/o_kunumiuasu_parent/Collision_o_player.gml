//show_msg("Aperte o direcional para cima para viajar:\nother.destination", 2);

show_interact_key = true;
text_bubble2(id, text, -1, 5, TEXT_Y_HEIGHT_2l);


if (other.interact and interact) {
	global.sound_controller.update_position_and_play(FMOD_EVENT.TRANSITION_BOAT, x, y);

	global.fader.to_room(target_rm, target_x, target_y);
	
	interact = false;
}

if(other.hp <  o_game.max_hp) {
	other.hp = o_game.max_hp;
	global.sound_controller.update_position_and_play(FMOD_EVENT.COLLECT_LIFE_FULL, x, y);
	global.options_controller.set_option(OPTIONS_PLAYER_HP, global.player.hp);
	
	repeat(o_game.gem_sparks) {
		var inst = instance_create_depth(x,y, depth, o_spark);
		inst.col_head = c_white;
		inst.col_tail = c_green;
	}
}
