/// @description move BG

var _cam_x = camera_get_view_x(view_camera[0]);
var _cam_y = camera_get_view_y(view_camera[0]);

layer_x(LAYER_BACKGROUND_1, _cam_x * 0.6);
layer_y(LAYER_BACKGROUND_1, (_cam_y * 0.6) + 287);

layer_x(LAYER_BACKGROUND_1_REFLEX, _cam_x * 0.6);
layer_y(LAYER_BACKGROUND_1_REFLEX, (_cam_y * 0.6) + 287 + 150);

layer_x(LAYER_BACKGROUND_2, _cam_x * 0.6 + 1800);
layer_y(LAYER_BACKGROUND_2, (_cam_y * 0.6) + 287);


layer_x(LAYER_BACKGROUND_2_REFLEX, _cam_x * 0.6 + 1800);
layer_y(LAYER_BACKGROUND_2_REFLEX, (_cam_y * 0.6) + 287 + 150);

layer_y(LAYER_BACKGROUND_4, (_cam_y * 0.6) + 40);

layer_x("LAYER_BARCO", (_cam_x * 0.4) + 2000);
layer_y("LAYER_BARCO", (_cam_y * 0.4) + 550);

layer_x(LAYER_BACKGROUND_5, _cam_x * 0.8);
layer_y(LAYER_BACKGROUND_5, (_cam_y * 0.8)+ 50);