function jump_dust() {
	var inst = instance_create_layer(x, y, LAYER_EFFECTS, o_player_dust_evade);
		inst.image_xscale = facing;	
}