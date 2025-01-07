function calc_entity_movement(_grav = global.grav, _drag = drag){
	
	//grav
	vsp += _grav;
	
	//drag
	//hsp = lerp(hsp,0, _drag);
	//stop
	if (abs(hsp) <= 0.005) {
		hsp=0;
	}
}