//show_msg("Aperte o direcional para cima para viajar:\nother.destination", 2);

show_interact_key = true;
text_bubble2(id, text, -1, 4, TEXT_Y_HEIGHT_2l);


if (other.interact and interact) {
	global.sound_controller.update_position_and_play(FMOD_EVENT.TRANSITION_BOAT, x, y);

	global.fader.to_room(target_rm, target_x, target_y);
	
	interact = false;
}
