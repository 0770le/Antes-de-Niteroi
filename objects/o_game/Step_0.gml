//show_debug_overlay(true);

if(global.timer++ >= 1000) {
	global.timer = 0;	
}

if(has_bow and !o_player.has_bow) {
	o_player.acquire_bow();	
}

//botao mouse pra teste
#region

if ( mouse_check_button_pressed(mb_right)){
	with(o_player) {
			hp = 0;
	}
}	

//if( mouse_check_button_pressed(mb_left)){
//	repeat(3) {
//		instance_create_layer(mouse_x, mouse_y, LAYER_INSTANCES, o_gem);
//	}
//}


//if( mouse_check_button_pressed(mb_left)){
//	repeat(3) {
//		instance_create_layer(mouse_x, mouse_y, LAYER_INSTANCES, o_gem);
//	}
//}

//if( mouse_check_button_pressed(mb_right)){
//	repeat(1) {
//		instance_create_layer(mouse_x, mouse_y, LAYER_INSTANCES, o_arrow);
//	}
//}

#endregion

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

