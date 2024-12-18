audio_play_sound(snd_pickup_gem, 5, false, global.volume);
show_msg("Novo registro adquirido: " + string(log_title),5);

repeat(o_game.gem_sparks) {
	var inst = instance_create_depth(x,y, depth, o_spark);
	//set colour
	switch(image_index) {
		case 0:
			var col_head = c_lime;
			var col_tail= make_colour_rgb(137, 190, 133);
		break;
			
		case 1:
			var col_head = c_yellow;
			var col_tail= make_colour_rgb(218 , 215,152);
		break;
			
		case 2:
			var col_head = c_aqua;
			var col_tail= make_colour_rgb(152,193,218);
		break;
			
		case 3:
			var col_head = c_fuchsia;
			var col_tail= make_colour_rgb(200,152,218);
		break;
			
		case 4:
			var col_head = c_red;
			var col_tail= make_colour_rgb(220,154,154);
		break;
	}
	inst.col_head = col_head;
	inst.col_tail = col_tail;
}
	

with(o_game) {
	logs_array[logs.LOG_PARENT] = true;
}

//update light position
with(light_id) {
	instance_destroy();
}





