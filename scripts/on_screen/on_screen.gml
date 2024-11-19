// on_screen(buffer);
//@arg buffer
//is the object on the screen


function on_screen(_tile_size = TILE_SIZE){

	
	var _left =   global.cx - _tile_size;
	var _right =  global.cx + global.cw + _tile_size;
	var _top =    global.cy - _tile_size;
	var _bottom = global.cy + global.ch + _tile_size;

	if ((( x > _left) and (x < _right)) and (y > _top) and ( y < _bottom)) {
		return true;
	} else {
		return false;
	}

}