/// @description move BG

var _cam_x = camera_get_view_x(view_camera[0]);
var _cam_y = camera_get_view_y(view_camera[0]);

layer_x(LAYER_BACKGROUND_5, _cam_x * 0.8);
layer_y(LAYER_BACKGROUND_5, (_cam_y * 0.8)+250);

layer_x(LAYER_BACKGROUND_6, _cam_x * 0.9);
layer_y(LAYER_BACKGROUND_6, (_cam_y * 0.9)+50);

layer_y(LAYER_BACKGROUND_7, (_cam_y * 0.9)-200);