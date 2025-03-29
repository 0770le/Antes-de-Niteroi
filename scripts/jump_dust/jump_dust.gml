function jump_dust(_x=x,_y=y) {
	
	var inst = instance_create_layer(_x, _y, LAYER_EFFECTS, o_player_dust_evade);
		inst.image_xscale = facing;	
}