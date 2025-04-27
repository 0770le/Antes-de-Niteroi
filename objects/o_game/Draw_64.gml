//GUI menu não eh afetado por ecala nem resolução

//720x360

// get gui dimensions
var gw = display_get_gui_width();
var gh = display_get_gui_height();

//display msg
if (alarm[DISPLAY_MSG] > 0) {
	draw_set_halign(fa_center);
	
	var _font = fnt_bookman_1;
	var _font2 = fnt_bookman_1_5;
	
	var _shadow_offset = 1;
	var _msg2_offset = 10;
	
	switch(o_camera.scale) {
		case 3:
			_font = fnt_bookman_3;
			_font2 = fnt_bookman_3_5;
			_shadow_offset = 3;
			_msg2_offset = 80;
			break;
		default: 
			_font = fnt_bookman_1;
			_font2 = fnt_bookman_1_5;
			_shadow_offset = 1;
			_msg2_offset = 10;
			break;
	}
	draw_set_font(_font);
	//sombra da msg
	draw_set_color(c_black);
	draw_text(gw/2, gh *.35 +_shadow_offset, msg); //.85, msg);
	//msg
	draw_set_color(c_white);
	draw_text(gw/2, gh *.35, msg); //.85, msg);
	
	draw_set_font(_font2);
	//sombra da msg
	draw_set_color(c_black);
	draw_text(gw/2, (gh *.35)+_msg2_offset +_shadow_offset, msg2); //.85, msg);
	//msg
	draw_set_color(c_white);
	draw_text(gw/2, (gh *.35)+_msg2_offset, msg2); //.85, msg);
}




