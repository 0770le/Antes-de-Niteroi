draw_self();

if (show_interact_key)
{
	draw_sprite(
		global.input_manager.get_input_in_game_action_sprite(INPUT_IN_GAME_ACTION.INTERACT),
		0,
		x - 10,
		bbox_top
	);
	
	show_interact_key = false;
}