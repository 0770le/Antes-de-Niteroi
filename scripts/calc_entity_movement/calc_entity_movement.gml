function calc_entity_movement(){
	vsp += global.grav;
	
	//drag
	if !on_ground() {
		hsp = lerp(hsp,0, drag*0.4);
	} else{
		hsp = lerp(hsp,0, drag*0.9);
	}
	//stop
	if (abs(hsp) <= 0.005) {
		hsp=0;
	}
}