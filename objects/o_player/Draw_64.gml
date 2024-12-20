/// @description Insert description here
// You can write your code in this editor
var _x = 13;
var _y = 46;

draw_sprite(s_HUD_back,0, _x, _y);
var _bar_width = sprite_get_width(s_HUD_hp_bar) * (hp/max_hp);
var _bar_height = sprite_get_height(s_HUD_hp_bar);
var _bar_x_offset = sprite_get_xoffset(s_HUD_hp_bar);
var _bar_y_offset = sprite_get_yoffset(s_HUD_hp_bar);
draw_sprite_part(s_HUD_hp_bar,0,0,0,_bar_width,_bar_height,_x-_bar_x_offset,_y-_bar_y_offset);
