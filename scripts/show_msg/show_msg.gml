/// desc show_msg(message, sec_to_display);
/// @arg message
/// @sec_to_display
///show message for the requied time

function show_msg(_msg, _time ){
	with(o_game) {
		alarm[DISPLAY_MSG] = _time * room_speed;
		msg = _msg;
	}
}