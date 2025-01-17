/// @description Insert description here
// You can write your code in this editor

with(instance_create_layer(x,y-3,LAYER_INSTANCES,o_corpse)) {
	sprite_index = s_chevalier_die;
	facing = other.facing;
}

with(instance_create_layer (side()+4*facing, y - 22, LAYER_INSTANCES, o_drop)) {
	sprite_index = s_chevalier_shield;
	bounce = 2;
	facing = other.facing;
}
