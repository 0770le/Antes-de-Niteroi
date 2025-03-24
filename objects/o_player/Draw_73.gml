var _cam_x = camera_get_view_x(view_camera[0]);
var _cam_y = camera_get_view_y(view_camera[0]);

var _x = _cam_x + 13;
var _y = _cam_y + 10;

var _bar_width = (sprite_get_width(s_HUD_hp_bar)/2) * o_game.max_hp;
var _bar_height = sprite_get_height(s_HUD_hp_bar);


var _hud_background_width = _bar_width + 60


draw_sprite_stretched(s_HUD_back,0,_cam_x-3,_y-5,_hud_background_width,sprite_get_height(s_HUD_back));
draw_sprite_stretched(s_HUD_hp_bar_loss,0,_x,_y,_bar_width,_bar_height);


_bar_width = (sprite_get_width(s_HUD_hp_bar)/2) * hp;
draw_sprite_stretched(s_HUD_hp_bar,0,_x,_y,_bar_width,_bar_height);


  