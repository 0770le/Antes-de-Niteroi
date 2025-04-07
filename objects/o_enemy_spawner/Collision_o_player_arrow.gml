if(should_spawn) {
	if(other.on_fire) {
		image_speed = 1;
		should_spawn = false;
	}

	instance_destroy(other);
}