/// @description move BG

var _cam_x = camera_get_view_x(view_camera[0]);
var _cam_y = camera_get_view_y(view_camera[0]);


layer_x(LAYER_BACKGROUND_1, (_cam_x * 0.95) + 150);
layer_y(LAYER_BACKGROUND_1,  (_cam_y * 0.6) + 600);

layer_y(LAYER_BACKGROUND_2, (_cam_y * 0.6) + 200);


layer_x(LAYER_BACKGROUND_3, (_cam_x * 0.7) + 1700);
layer_y(LAYER_BACKGROUND_3, (_cam_y * 0.6) + 450);



layer_x(LAYER_BACKGROUND_6, _cam_x * 0.8);
layer_y(LAYER_BACKGROUND_6, (_cam_y * 0.8)-200);

layer_x(LAYER_BACKGROUND_7, (_cam_x * 0.95) + 200);
layer_y(LAYER_BACKGROUND_7, (_cam_y * 0.95) + 100);

layer_y(LAYER_BACKGROUND_9, (_cam_y * 0.5));