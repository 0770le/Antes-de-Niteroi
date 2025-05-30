/// @description Insert description here
// You can write your code in this editor

draw_set_font(fnt_indio_medium);

var _m = floor(time/(60*60));
var _s = floor(time/(60)) mod 60;
var _ms = time mod 60;

var _string_s = _s < 10? "0"+string(_s) : string(_s);
var _string_ms = _ms < 10? "0"+string(_ms) : string(_ms);


draw_set_halign(fa_center);
draw_set_valign(fa_top);

if(time > 30*60) {
	draw_set_color(c_white);
} else {
	draw_set_color(choose(COLOR_RED,COLOR_RED,COLOR_RED,COLOR_RED,COLOR_RED, COLOR_YELLOW, c_white));
}

var _x =  global.cx +  global.cw - 10;
var _y =  global.cy + 40;

draw_text(_x-100, _y, "0"+string(_m));
draw_text(_x-80, _y, ":");
draw_text(_x-60, _y, _string_s);
draw_text(_x-40, _y, ":");
draw_text(_x-20, _y, _string_ms);

draw_set_halign(fa_left);
draw_set_valign(fa_bottom);
draw_set_color(c_white);

if(flash) {
	_x = camera_get_view_x(view_camera[0]);
	_y = camera_get_view_y(view_camera[0]);
	
	draw_rectangle(_x, _y, _x + global.cw, y+  global.ch, false);
	flash =false;	
}