function calc_entity_movement(){
	vsp += global.grav;
	
	hsp = lerp(hsp,0, drag*0.9);
	
	//stop
	if (abs(hsp) <= 0.005) {
		hsp=0;
	}
}