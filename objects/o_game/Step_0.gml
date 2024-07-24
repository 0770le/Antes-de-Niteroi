//show_debug_overlay(true);

//botao mouse pra teste
#region
//if( mouse_check_button_pressed(mb_left)){
//	repeat(3) {
//		instance_create_layer(mouse_x, mouse_y, "Drops", o_gem);
//	}
//}

//if( mouse_check_button_pressed(mb_right)){
//	repeat(1) {
//		instance_create_layer(mouse_x, mouse_y, "Drops", o_arrow);
//	}
//}

#endregion

if (game_over_lose == true) {
	with(o_player) {
		get_input();
		if ((jump == true) or (attack == true)) {
			game_restart();
		}
	}
}
//reduce delay time in game over room
if (game_over_won) {
	game_over_won_delay--;
}