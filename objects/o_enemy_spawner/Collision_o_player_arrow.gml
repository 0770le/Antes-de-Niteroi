if(should_spawn) {
	if(other.on_fire) {
		global.sound_controller.play(FMOD_EVENT.OBJECTS_FIRE);
		image_speed = 1;
		should_spawn = false;
		instance_destroy(other);
	}
}