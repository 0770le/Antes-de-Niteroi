
function crouched(){
	state = states.CROUCH;
	o_sound_controller.update_event_parameter_and_play_pos(FMOD_EVENT.CROUCH, FMOD_PARAMETER_NAME_MOVE, FMOD_PARAMETER_MOVE_CROUCH.CROUCH, x, y)
	o_camera.y_offset = 0;
	hsp=0;
	image_index = 0;
	image_speed = 1;
	//reset hiding conditions
	hide_ready = false;
	hide_cover = false;
	alarm[HIDING] = room_speed * hide_delay;

}