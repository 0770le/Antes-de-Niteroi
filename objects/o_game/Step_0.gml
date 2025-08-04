//show_debug_overlay(true);

if(global.timer++ >= 1000) {
	global.timer = 0;	
}


if (game_over_lose) {
	with(o_player) {
		get_input();
		if (jump or attack) {
			game_restart();
		}
	}
}
//reduce delay time in game over room
if (game_over_won) {
	game_over_won_delay--;
}

