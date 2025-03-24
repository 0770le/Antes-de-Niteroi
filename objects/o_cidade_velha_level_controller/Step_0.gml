/// @description move BG

var _cam_x = camera_get_view_x(view_camera[0]);
var _cam_y = camera_get_view_y(view_camera[0]);

layer_x(LAYER_BACKGROUND_1, _cam_x * 0.50);
layer_x(LAYER_BACKGROUND_2, (_cam_x * 0.50) + 2000);
layer_x(LAYER_BACKGROUND_4, (_cam_x * 0.60) + 1050);

layer_x(LAYER_BACKGROUND_5, (_cam_x * 0.90) + 1050);
layer_x(LAYER_BACKGROUND_6, _cam_x * 0.95);


layer_y(LAYER_BACKGROUND_6, (_cam_y * 0.2) + 50);