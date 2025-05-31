/// @description move BG

var _cam_x = camera_get_view_x(view_camera[0]);
var _cam_y = camera_get_view_y(view_camera[0]);

layer_x(LAYER_BACKGROUND_5, _cam_x * 0.8);
layer_y(LAYER_BACKGROUND_5, (_cam_y * 0.8)+250);

layer_x(LAYER_BACKGROUND_6, _cam_x * 0.9);
layer_y(LAYER_BACKGROUND_6, (_cam_y * 0.9)+50);

layer_y(LAYER_BACKGROUND_7, (_cam_y * 0.8)-50);



var ground = layer_get_depth(layer_get_id(LAYER_GROUND));


var water = layer_get_depth(layer_get_id(LAYER_GROUND));

if(point_distance(1690,910, global.player.x,global.player.y) < 50) {
	var _text = global.i18n.get_message("tip-bring-fire");
	text_bubble2(global.player, _text, 200, 6, TEXT_Y_HEIGHT_2l);
}