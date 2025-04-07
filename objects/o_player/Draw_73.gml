var _cam_x = camera_get_view_x(view_camera[0]);
var _cam_y = camera_get_view_y(view_camera[0]);

var _x = _cam_x + 25;
var _y = _cam_y + 12;

var _bar_width = (sprite_get_width(s_HUD_hp_bar)/2) * o_game.max_hp;
var _bar_height = sprite_get_height(s_HUD_hp_bar);


var _hud_background_width = _bar_width + 60

draw_set_alpha(0.6);
draw_sprite_stretched(s_HUD_back,0,_cam_x+2,_cam_y+ 6,_hud_background_width,sprite_get_height(s_HUD_back));
draw_set_alpha(1);
draw_sprite_stretched(s_HUD_hp_bar_loss,0,_x,_y,_bar_width,_bar_height);


_bar_width = (sprite_get_width(s_HUD_hp_bar)/2) * hp;
draw_sprite_stretched(s_HUD_hp_bar,0,_x,_y,_bar_width,_bar_height);

//draw_set_color(c_white);
//draw_sprite(s_HUD_lives, 0, _cam_x + global.cw - 70, _y-20);
//draw_set_font(global.fontLives);
//draw_text(_cam_x + global.cw - 15, _y+2, string(lives2));

if(o_game.has_bow) {
	draw_sprite(s_HUD_arrows, 0, _cam_x + 10, _y+40);
	draw_set_font(global.fontArrow);
	draw_text(_cam_x + 30, _y+55, string(arrows));
}
