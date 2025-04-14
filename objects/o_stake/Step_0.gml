if hp <= 0 {
	die = true;
	
	global.sound_controller.update_event_parameter_and_play_pos(
		FMOD_EVENT.WOOD_BARRIER_BREAK, 
		FMOD_PARAMETER_NAME_MOVE, 
		FMOD_PARAMETER_MOVE_VALUE_WOOD_BREAK.BREAK, 
		x, y
	);
} else if (previous_hp > hp) {
	previous_hp = hp;
	
	global.sound_controller.update_event_parameter_and_play_pos(
		FMOD_EVENT.WOOD_BARRIER_BREAK, 
		FMOD_PARAMETER_NAME_MOVE, 
		FMOD_PARAMETER_MOVE_VALUE_WOOD_BREAK.HIT, 
		x, y
	);
} 

image_xscale = facing;

 if die {
	instance_destroy();
 }

