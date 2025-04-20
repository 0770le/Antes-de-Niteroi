/// @description Insert description here
// You can write your code in this editor

if(create) {
	passaro = instance_create_layer(x,y,LAYER_INSTANCES,o_passaro);
	passaro.spd = spd;
	passaro.range = range;
	passaro.sprite_index = idle_sprite;
	passaro.flying_sprite = flying_sprite;
	
	create = false;
}

if(!instance_exists(passaro) and point_distance(x,y,o_player.x,o_player.y) > GAME_W + TILE_SIZE * 4) { // GAME_W*2
	create = true;	
}