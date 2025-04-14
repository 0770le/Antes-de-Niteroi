/// @description Insert description here
// You can write your code in this editor
draw_set_color(c_white);
if(explosion_time> explosion_time_final-10 and explode) {
	draw_set_alpha(0.5);
	var _height = (explosion_time - (explosion_time_final-10))*10;
	draw_rectangle(0,195-_height,room_width,195+_height,false);
}

if(flash_alpha > 0) {
	draw_set_alpha(flash_alpha);
	draw_rectangle(0,0,room_width,room_height,false);
}

draw_set_alpha(1);

if(credits_alpha > 0) {
	draw_set_alpha(credits_alpha);
	draw_set_color(c_black);
	
	draw_rectangle(80,0,450,room_height,false);
	
	draw_set_alpha(1);
	draw_set_color(c_white);
}

if(credits) {
	var _x_title = 250;
	var _x_name = 250 + 20;	
	
	draw_set_font(fnt_arial_medium_to_small);
	var i = 0;
	for(i = 0; i < array_length(credits_name); i++) {
		draw_set_halign(fa_right);
		draw_text(_x_title, credits_y + (credits_y_height*i), credits_title[i]);
		draw_set_halign(fa_left);
		draw_text(_x_name, credits_y + (credits_y_height*i), credits_name[i]);
	}
	
	draw_sprite(s_realizacao, 0, _x_title, credits_y + (credits_y_height*i));
}

if(end_credits_alpha > 0) {
	draw_set_alpha(end_credits_alpha);
	draw_set_color(c_black);
	
	draw_rectangle(0,0,room_width,room_height,false);
	
	draw_set_alpha(1);
	draw_set_color(c_white);
}