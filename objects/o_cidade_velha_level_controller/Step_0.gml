/// @description move BG

var _cam_x = camera_get_view_x(view_camera[0]) ;
layer_x(LAYER_BACKGROUND_1, _cam_x * 0.50);
layer_x(LAYER_BACKGROUND_2, (_cam_x * 0.50) + 2000);
layer_x(LAYER_BACKGROUND_4, (_cam_x * 0.60) + 1050);

layer_x(LAYER_BACKGROUND_5, _cam_x * 0.95);