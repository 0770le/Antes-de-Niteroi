function on_screen(_buffer = 50){

	var _left =   global.cx - _buffer;
	var _right =  global.cx + global.cw + _buffer;
	var _top =    global.cy - _buffer;
	var _bottom = global.cy + global.ch + _buffer;

	return ((( bbox_right > _left) and (bbox_left < _right)) and (bbox_bottom > _top) and ( bbox_top < _bottom)) 
}