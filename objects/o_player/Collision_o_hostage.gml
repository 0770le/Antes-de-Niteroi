with(other){
	if !saved {
		saved = true;
		audio_play_sound(snd_enemies_spawn, 30, false, global.volume);
		var _msg = "Você liberou uma nova travessia!";
		show_msg(_msg, 2);
		runned_once = true;
		alarm[ONCE] = room_speed * 2.2;
		
	} else { 
		//show_msg 
		if !runned_once {
			runned_once = true;
			show_msg("kunumĩuasu: Ha'evete, Morubixaba!", 2);
			call_later(2.5,  time_source_units_frames,function(){show_msg(msg, 2)});
			alarm[ONCE] = room_speed * 5;
		}
	}
	
	//get layer id
	//var layer_id = layer_get_id("Travel" + string(other.travel)); //ex:stage1 set on creation code

	//game var
	//activate layer
	//instance_activate_layer(layer_id);
	
}