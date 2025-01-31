with(instance_create_layer(x,y-3,LAYER_INSTANCES,o_corpse)) {
	sprite_index = s_frances_die;
	facing = other.facing;
}

with(instance_create_layer (side()+4*facing, y - 22, LAYER_INSTANCES, o_drop)) {
	sprite_index = s_frances_capacete;
	bounce = 2;
	facing = other.facing;
}

with(instance_create_layer (side()+4*facing, y - 22, LAYER_INSTANCES, o_drop)) {
	sprite_index = s_france_arma;
	bounce = 2;
	facing = other.facing;
}