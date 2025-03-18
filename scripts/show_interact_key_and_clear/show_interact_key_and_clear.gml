function show_interact_key_and_clear(_target = noone)
{
	if (show_interact_key)
	{
		var _scale = global.input_manager.get_input_sprite_scale_alt();
		
		draw_sprite_ext(
			global.input_manager.get_input_in_game_action_sprite_alt(INPUT_IN_GAME_ACTION.INTERACT),
			0,
			x - 10,
			bbox_top,
			_scale,
			_scale,
			0,
			c_white,
			1
		);
	
		show_interact_key = false;
	}
}