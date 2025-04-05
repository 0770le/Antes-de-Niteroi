
function player_die_state(){

	if (respawn_coldown > 0) 
	{
		respawn_coldown--;
	}
	else if (respawn_coldown == 0)
	{
		if (lives2 > 0)
		{
			var _respawn_room = global.options_controller.get_option(OPTIONS_LAST_ROOM);
			var _respawn_x = global.options_controller.get_option(OPTIONS_SPAWN_X);
			var _respawn_y = global.options_controller.get_option(OPTIONS_SPAWN_Y);
			
			global.fader.to_room(
				_respawn_room,
				_respawn_x,
				_respawn_y
			);
		}
		else 
		{
			global.fader.to_room(rm_main_menu);
		}	
		
		respawn_coldown--;
	}
	
	if(instance_exists(corpse)){
		x = corpse.x;
		y = corpse.y;
	}
}