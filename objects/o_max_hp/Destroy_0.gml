/// @desc destroy hp light

//update light position
with(light_id) {
	instance_destroy();
}

repeat(o_game.gem_sparks) {
	var inst = instance_create_depth(x,y, depth, o_spark);
	inst.col_head = c_white;
	inst.col_tail = c_red;
}


