/// @descr launch (_vsp, _hsp, _dir = facing)

function launch(_vsp, _hsp, _dir = facing){
	_vsp = _vsp*-1;
	_hsp = abs(_hsp);
	vsp = _vsp;
	hsp += _hsp *_dir;
	
}