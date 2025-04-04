if (other.on_fire == true) {
	if (!on_fire) 
	{
		global.sound_controller.update_position_and_play(
			FMOD_EVENT.OBJECTS_FIRE,
			x, y
		);
	}
	on_fire = true;
}

with(other) {
	die = true;
}