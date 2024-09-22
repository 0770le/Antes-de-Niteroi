/// @description Calcula e retorna velocidade inicial necessária para acertar o alvo
/// @param x_init Coordenada x inicial
/// @param y_init Coordenada y inicial
/// @param x_target Coordenada x final
/// @param y_target Coordenada y final
/// @param _grav Gravidade constante
/// @param _drag Coeficiente de atrito horizontal


//function ballistic_arrow(x_init = x, y_init = y , x_target = o_player.x + o_player.hsp, y_target = o_player.y , _hsp = spd, _grav = global.grav, _drag = drag){
	
//	//time in air
//	var _time = (abs(x_target - x_init)/abs(_hsp));
	
//	//hsp with drag
//	_hsp =  _hsp - power(_drag, _time);
	
//	//vsp needed
//	var _vsp = (y_target - y_init + 0.5 * _drag * power(_time,2))/ _time + _drag * _hsp;
//	_vsp = round(_vsp);
	
//	return _vsp;
	
	
//}

//function ballistic_arrow(x_init = x, y_init = y , x_target = (o_player.x + o_player.hsp) , y_target = o_player.y - o_player.sprite_height/2 , _grav = global.grav, _drag = drag){
	
//	var _delta_h = x_target - x_init;
//	var _delta_v = y_target - y_init;
	
//	var _distance = point_distance(x_init, y_init , x_target, y_target);
	
//	var _time = room_speed//sqrt((2* abs(_delta_v))/_grav);
	
//	var _hsp = _delta_h / _time;
//	var _vsp = (_grav * _time)/2;
	
//	var _time_adjust = 1 - exp(-drag*_time);
//	_hsp /= _time_adjust;
//	_vsp /= _time_adjust;
	
//	spd = _hsp*facing;
//	v_spd = _vsp;
	
//}


