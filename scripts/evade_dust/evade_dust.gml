function evade_dust() { //objeto diferente!
	var inst = instance_create_layer(x, y, LAYER_EFFECTS, o_player_dust_jump);
		inst.image_xscale = -1* facing;	
}