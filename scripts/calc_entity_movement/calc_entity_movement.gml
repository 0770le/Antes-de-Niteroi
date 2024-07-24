function calc_entity_movement(){
	vsp += global.grav;
	
	//drag
	hsp = lerp(hsp,0, drag);

	//stop
	if (abs(hsp) <= 0.05) {
		hsp=0;
	}
}