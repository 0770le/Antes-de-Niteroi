
	
// Colecionáveis 

var _cam_x = camera_get_view_x(view_camera[0]);
var _cam_y = camera_get_view_y(view_camera[0]);

var _hud_back_w = sprite_get_width(s_HUD_mirror);
var _hud_back_h = sprite_get_height(s_HUD_mirror);
var _hud_right_x = _cam_x + camera_get_view_width(view_camera[0]) - _hud_back_w - 2;
var _hud_right_y = _cam_y + 6;

draw_set_alpha(0.6);
draw_sprite_stretched(s_HUD_mirror, 0, _hud_right_x, _hud_right_y, _hud_back_w, _hud_back_h);
draw_set_alpha(1);

var _text = $"{global.catalog_window.get_total_unlocked_items()}/{global.catalog_window.total_items}";

// Posição do texto (centralizado)
var _text_x = _cam_x + camera_get_view_width(view_camera[0]) -45; //_hud_right_x + (_hud_back_w div 2);
var _text_y = _hud_right_y + (_hud_back_h div 2);

// Largura do número com a fonte Arrow
draw_set_font(global.fontArrow);
draw_set_halign(fa_right);
draw_set_valign(fa_middle);
draw_set_color(c_white);
draw_text(_text_x, _text_y, _text);

