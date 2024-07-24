
function check_enemy_hp(){
	if ( hp <= 0) {
		//hp drop
		var _chance = random(1);
		if (_chance <= hp_drop_chance) {
			instance_create_layer(x,bbox_top, "Drops", o_hp);
			audio_play_sound(snd_hp_spawning, 15, false);
		}
		//play death sound
		audio_play_sound(snd_enemy_dying, 10, false);
		//play gem spawn sound
		audio_play_sound(snd_gems_spawning, 15, false);
		
		repeat(death_gem_value) {
			instance_create_layer(x, bbox_top, "Drops", o_gem);
			repeat(o_game.enemy_sparks) {
				var inst = instance_create_depth(x, (bbox_bottom + bbox_top)/2, depth-1, o_spark);
				switch(object_index) {
					case o_frog:
						if (choose(0,1,1)) {
							//gray
							inst.col_head = c_gray;
							inst.col_tail = c_dkgray;
						} else{
							//white
							inst.col_head = c_white;
							inst.col_tail = c_ltgray;
						}
					break;
					case o_bug:
						if (choose(0,1,1)) {
							//red
							inst.col_head = c_red;
							inst.col_tail = c_maroon;
						} else{
							//green
							inst.col_head = c_lime;
							inst.col_tail = c_green;
						}
					break;
				//	case inimigo generico
				case o_enemy:
						if (choose(0,1,1)) {
							//red
							inst.col_head = c_red;
							inst.col_tail = c_maroon;
						} else{
							//white
							inst.col_head = c_white;
							inst.col_tail = c_ltgray;
						}
				break;
				}
			}
		}
		//score
		switch(object_index) {
			case o_frog:
				score += 50;
			break;
			case o_bug:
				score += 100;
			break;
		}
		
		
		//curupira
		switch(object_index) {
			case o_enemy:
			o_player.curupira_count+=1
			break;
		}
		
		o_player.engaged = false;
		
		//screnn shake
		scr_screen_shake(.15,-1);
		instance_destroy();
	}	
}