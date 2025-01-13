// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function text_bubble2(_inst, _text, _duration = -1, _x_scale = -1, _y_scale = -1, _x_off = 0, _y_off = -100){
	var _create = true;
	
	with(o_text_bubble) {
		if(inst == _inst and duration > 3) {
			_create = false;
			break;
		}
	}
	
	if(_create and instance_exists(_inst)) {
		if(_y_off == -100) {
			_y_off = -(y - _inst.bbox_top) - 5;
		}
		if(_x_scale == -1 or _y_scale == -1) {
			_x_scale = floor(_text_len/7);
			_y_scale = floor(_text_len/10);
		}
		if(_duration == -1) {
			_duration = string_length(_text) * 5;
		}
		
		with(instance_create_layer(-500, -500, LAYER_MESSAGES,o_text_bubble)) {
			inst = _inst;
			displayed_text = _text;
			
			offset_x = _x_off;
			offset_y = _y_off;
			
			duration = _duration;
			
			image_xscale = _x_scale;
			image_yscale = _y_scale;
		}
	}
}