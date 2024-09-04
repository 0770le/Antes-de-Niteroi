function calc_entity_movement(){
	vsp += global.grav;
	
	//drag
	hsp = lerp(hsp,0, drag/2);

	//stop
	if (abs(hsp) <= 0.0005) {
		hsp=0;
	}
}