
var _cam_x = camera_get_view_x(view_camera[0]);
var _cam_y = camera_get_view_y(view_camera[0]);


layer_x(LAYER_BACKGROUND_1, (_cam_x * 0.6) + 300);
layer_y(LAYER_BACKGROUND_1, (_cam_y * 0.3) + 762);


layer_x(LAYER_BACKGROUND_1_REFLEX, (_cam_x * 0.6) + 300);
layer_y(LAYER_BACKGROUND_1_REFLEX, (_cam_y * 0.3) + 762 + 154);

layer_x(LAYER_BACKGROUND_2, (_cam_x * 0.7) + 590);
layer_y(LAYER_BACKGROUND_2, (_cam_y * 0.7) + 56);

layer_x(LAYER_BACKGROUND_3, _cam_x * 0.8 + 500);
layer_y(LAYER_BACKGROUND_3, (_cam_y * 0.8) - 156);

layer_y(LAYER_BACKGROUND_4, (_cam_y * 0.3) + 515);

layer_x(LAYER_BACKGROUND_5, _cam_x * 0.8);
layer_y(LAYER_BACKGROUND_5, (_cam_y * 0.8)+ 50);