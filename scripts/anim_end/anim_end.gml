///@desc return true if animation has ended
function anim_end(){
	if  image_index >= (image_number - sprite_get_speed(sprite_index)/room_speed) {
		return true;
	}
}

