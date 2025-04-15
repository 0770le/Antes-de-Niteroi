/// @description move BG

if(!sun_disabled and keyboard_check(vk_pagedown)) {
	if(disable_sun++ > 240) {
		sun_disabled = true;
		with(o_sun_blocker) {
			instance_destroy();	
		}
		var lay_id = layer_get_id("Backgrounds_sun");
	    layer_set_visible(lay_id, false);
	}
} else {
	disable_sun = 0;
}


var _cam_x = camera_get_view_x(view_camera[0]);
var _cam_y = camera_get_view_y(view_camera[0]);


layer_x(LAYER_BACKGROUND_1, (_cam_x * 0.95) + 150);
layer_y(LAYER_BACKGROUND_1,  (_cam_y * 0.6) + 600);

layer_y(LAYER_BACKGROUND_2, (_cam_y * 0.6) + 200);


layer_x(LAYER_BACKGROUND_3, (_cam_x * 0.7) + 1700);
layer_y(LAYER_BACKGROUND_3, (_cam_y * 0.6) + 450);


layer_x("LAYER_BARCO", (_cam_x * 0.5) + 2350);
layer_y("LAYER_BARCO", (_cam_y * 0.5) + 690);


layer_x(LAYER_BACKGROUND_6, _cam_x * 0.8);
layer_y(LAYER_BACKGROUND_6, (_cam_y * 0.8)-200);

layer_x(LAYER_BACKGROUND_7, (_cam_x * 0.95) + 200  + 13);
layer_y(LAYER_BACKGROUND_7, (_cam_y * 0.95) + 100 + 13);

layer_x("Backgrounds_sun", (_cam_x * 0.95)	-39);
layer_y("Backgrounds_sun", (_cam_y * 0.95) -140);
layer_background_alpha(sun_light_id, sun_alpha);

sun_x = _cam_x * 0.95 + 310;
sun_y = _cam_y * 0.95 + 210;

layer_y(LAYER_BACKGROUND_9, (_cam_y * 0.5));

if(collision_point(sun_x,sun_y,o_sun_blocker,false,false)!= noone and sun_alpha > 0) {
	sun_alpha -= 0.02;
} else if (sun_alpha < 0.3) {
	sun_alpha += 0.02;	
}