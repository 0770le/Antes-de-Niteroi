/// @description Insert description here
// You can write your code in this editor

with(instance_create_layer(x,y-3,LAYER_INSTANCES,o_corpse)) {
	sprite_index = s_tupinamba_melee_die;
	facing = other.facing;
}

with(instance_create_layer (side()+4*facing, y - 22, LAYER_INSTANCES, o_drop)) {
	sprite_index = s_tupinamba_melee_arma;
	bounce = 2;
	facing = other.facing;
}

if(o_game.has_bow and irandom(1)>0) {
	instance_create_layer(x,bbox_top, LAYER_INSTANCES, o_arrows);
}