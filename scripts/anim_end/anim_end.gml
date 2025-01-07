///@desc return true if animation has ended
function anim_end(){  //(image_index >= (image_number - 1))
	//if  image_index >= (image_number - sprite_get_speed(sprite_index)/room_speed) {
	//	return true;
	//}
	var frame = image_index;
	var frame_range = image_speed * sprite_get_speed(sprite_index) / game_get_speed(gamespeed_fps);

	return image_index >= image_number - frame_range && image_index < image_number;
}

