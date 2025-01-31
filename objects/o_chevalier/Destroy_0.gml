/// @description Insert description here
// You can write your code in this editor

with(instance_create_layer(x,y,LAYER_INSTANCES,o_generic_animation)) {
	sprite_index = s_chevalier_die;
	image_xscale = other.facing;
}
