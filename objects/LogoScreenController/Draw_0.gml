
if(screenAlpha > 0) {
	draw_set_alpha(screenAlpha);
	draw_set_color(c_black);
	draw_rectangle(0,0,room_width,room_height,false);
	draw_set_alpha(1);
	draw_set_color(c_white);
}




