function check_player_hp() {
	if hp <= 0 {
		state = states.DIE;
		
		//avoid start next state on ground
		y += -2;
		launch(4,5,-1*facing)
		
		image_index = 0;	
		image_speed = 1;
		scale_x=1;
		scale_y=1;
		lives --;
		audio_play_sound(snd_player_die, 5, false, global.volume);	
	}
	
	if(hp_losing < hp) {
		hp_losing = hp;
	}
	if(hp_losing > hp) {
		hp_losing -= 0.01;	
	}
}