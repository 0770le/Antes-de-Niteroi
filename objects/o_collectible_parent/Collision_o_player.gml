/// @description collect

global.sound_controller.update_position_and_play(FMOD_EVENT.COLLECT_REGISTER, x, y);

show_msg("Novo registro adquirido: " + string(log_title),5);
o_game.collectible[collectible_index] = true;

global.catalog_controller.unlock_item(catalog_item_type);

repeat(o_game.gem_sparks) {
	var inst = instance_create_depth(x,y, depth, o_spark);
	//set colour
	var col_head = c_white;
	var col_tail = c_white;
	
	switch(image_index) {
		case 0:
			col_head = c_lime;
			col_tail= make_colour_rgb(137, 190, 133);
		break;
			
		case 1:
			col_head = c_yellow;
			col_tail= make_colour_rgb(218 , 215,152);
		break;
			
		case 2:
			col_head = c_aqua;
			col_tail= make_colour_rgb(152,193,218);
		break;
			
		case 3:
			col_head = c_fuchsia;
			col_tail= make_colour_rgb(200,152,218);
		break;
			
		case 4:
			col_head = c_red;
			col_tail= make_colour_rgb(220,154,154);
		break;
	}
	inst.col_head = col_head;
	inst.col_tail = col_tail;
}
	

with(o_game) {
	logs_array[logs.LOG_PARENT] = true;
}

instance_destroy();