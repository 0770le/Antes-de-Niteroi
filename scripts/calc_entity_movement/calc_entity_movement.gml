function calc_entity_movement(_grav = global.grav, _drag = drag){
	
	//grav
	vsp += _grav;
	if(vsp > 8) {
		vsp = 8;	
	}
	
	//drag
	hsp = lerp(hsp,0, _drag);
	
	//stop
	if (abs(hsp) <= 0.005) {
		hsp=0;
	}
}