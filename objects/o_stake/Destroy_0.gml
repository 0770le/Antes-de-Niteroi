repeat(debris_number) {
	var inst = instance_create_depth(x-random(10)+5,y-10-random(20), depth, o_drop);
	inst.sprite_index = s_stake_piece;
	inst.image_speed = 0;
	inst.image_index = irandom(sprite_get_number(s_stake_piece)-1);
	inst.hsp_initial *= choose(1,-1);
	inst.grav = 0.2;
	
}