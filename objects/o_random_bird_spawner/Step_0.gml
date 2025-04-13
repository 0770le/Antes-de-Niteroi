
if (!type_picked){
	bird_type = choose(0,1,2);
	type_picked = true;
	set_bird_type();
}

//create_bird
if(create) {
	alarm[0] = 3;
	create= false;
}

if(!instance_exists(passaro)and (alarm[0] == -1) and point_distance(x,y,o_player.x,o_player.y) > GAME_W/2 + TILE_SIZE * 4) { // GAME_W*2
	create = true;	
}