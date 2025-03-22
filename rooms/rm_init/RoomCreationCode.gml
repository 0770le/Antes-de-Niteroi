if(!instance_exists(o_game))
	instance_create_depth(0,0,0,o_game);
if(!instance_exists(o_camera))
	instance_create_depth(0,0,0,o_camera);
if(!instance_exists(o_sound_controller))
	instance_create_depth(0,0,0,o_sound_controller);
	
//move to main room
room_goto_next();
	