///desc@ CREATE BIRD

/// create bird delay for flock

passaro = instance_create_layer(x,y,LAYER_INSTANCES,o_passaro);
passaro.spd = spd;
passaro.range = range;
passaro.sprite_index = idle_sprite;
passaro.flying_sprite = flying_sprite;
	