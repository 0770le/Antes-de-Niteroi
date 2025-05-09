
draw_set_color(c_white);

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

//draw_sprite(s_HUD_lives, 0, _cam_x + global.cw - 70, _y-20);
//draw_set_font(global.fontLives);
//draw_text(_cam_x + global.cw - 15, _y+2, string(lives2));

draw_set_color(c_white)
if(o_game.has_bow) {
	draw_set_halign(fa_left);
	draw_sprite(s_HUD_arrows, 0, _cam_x + 10, _y+40);
	draw_set_font(global.fontArrow);
	var _s = arrows < 10? "0"+string(arrows) : string(arrows);
	draw_text(_cam_x + 30, _y+55, string(arrows) + "/" + string(global.game.max_arrows));
}





	
// Colecionáveis 
var _hud_back_w = sprite_get_width(s_HUD_mirror);
var _hud_back_h = sprite_get_height(s_HUD_mirror);
var _hud_right_x = _cam_x + camera_get_view_width(view_camera[0]) - _hud_back_w - 2;
var _hud_right_y = _cam_y + 6;

draw_set_alpha(0.6);
draw_sprite_stretched(s_HUD_mirror, 0, _hud_right_x, _hud_right_y, _hud_back_w, _hud_back_h);
draw_set_alpha(1);

// Valores

with(obj_catalog_window) {
	var _total_items = array_length(catalog_items);
	var _unlocked_items = array_length(
		array_filter(catalog_items, function (_item) { return !_item.locked })
	);
	o_player._total_items =_total_items;
	o_player._unlocked_items =_unlocked_items;
}


var _text = string(_unlocked_items) + " / " + string(_total_items);

// Posição do texto (centralizado)
var _text_x = _hud_right_x + (_hud_back_w div 2);
var _text_y = _hud_right_y + (_hud_back_h div 2);

// Largura do número com a fonte Arrow
draw_set_font(global.fontArrow);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_color(c_white);
draw_text(_text_x, _text_y, _text);






//// Agora desenha o % ao lado, em fonte vermelha default
//draw_set_font(-1); // Fonte padrão
//draw_set_color(c_red);
//var _text_width = string_width(_text);
//draw_text(_text_x + (_text_width div 2) + 1, _text_y, " %");
