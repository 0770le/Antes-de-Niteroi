if (other.on_fire) {
	instance_destroy();
	global.fader.to_room(target_rm, target_x, target_y);
}

instance_destroy(other);