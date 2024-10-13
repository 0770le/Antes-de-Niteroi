with(other){
	if !saved {
		saved = true;
		audio_play_sound(snd_enemies_spawn, 30, false, global.volume);
		var _msg = "Você liberou uma nova área!";
		show_msg(_msg, 3);
	
	} else {
		//show_msg 
		show_msg("kunumĩuasu: Ha'evete, Morubixaba!", 2);
	}
	
	//get layer id
	//var layer_id = layer_get_id("Travel" + string(other.travel)); //ex:stage1 set on creation code

	//game var
	//activate layer
	//instance_activate_layer(layer_id);
	
}