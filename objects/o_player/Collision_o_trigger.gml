var _msg = "Find the chest to open the door";

if (other.stage != 999) { //stage999 is final door in final room
	//get layer id
	var layer_id = layer_get_id("Stage" + string(other.stage)); //ex:stage1 set on creation code

	//activate layer
	instance_activate_layer(layer_id);

	//destroy o_trigger
	instance_destroy(other);

//play spawn sound
audio_play_sound(snd_enemies_spawn, 30, false, global.volume);

	//close door
	if ((other.stage == 5) and (!o_chest.open)) {
		if (layer_get_visible(layer_get_id("Door"))) {
			audio_play_sound(snd_door_opening_closing, 50, false, global.volume);
		}
		layer_set_visible(layer_get_id("Door"), false);
		
		//give player a msg
		show_msg(_msg, 3);
	}
} else {
	//game end
	if (o_chest.open) {
		o_game.game_over_won = true;
		fade_to_room(rm_game_end, 0, 0,1 , c_black);
		state= states.GAME_END;
		instance_destroy(other);
	} else {
	//give player a msg
		show_msg(_msg, 3);
	}
}