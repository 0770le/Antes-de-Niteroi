/// function scr_screen_shake(seconds, shake_amount); 
///@arg secounds_to_shake
///@arg shake_amount_-1def

var _time = argument0;
var _amount = argument1;


function scr_screen_shake(_time,_amount){
	with(o_camera){
		//default
		if (_amount == 1) {
			_amount = screen_shake_amount_initial;
		}
		screen_shake = true;
		alarm[SCREEN_SHAKE_TIME] = room_speed * _time;
		screen_shake_amount = _amount;
	}
}