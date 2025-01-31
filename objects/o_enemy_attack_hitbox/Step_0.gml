//cycle through all enemies and see if they were hit
with (instance_place(x,y, o_player)) {
	process_enemy_attack();
}	

instance_destroy();

