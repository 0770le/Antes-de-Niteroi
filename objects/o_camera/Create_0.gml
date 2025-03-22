global.camera = self;
//get dimensions. modifica a info pega no camera

var _w		= 480;
var _h		= 270;
var _scale	= 3;

//create camera.(room_x, room_y, width, height, [angle, object, x_speed, y_speed, x_border, y_border])
camera = camera_create_view(0,0,_w,_h,0,-1,-1,-1,128,128 ) 
view_set_camera(0, camera);

window_set_size(_w * _scale, _h * _scale);

// declarando posiçao da camera
global.cx = 0;
global.cy = 0;
global.cw = 0;
global.ch = 0;

//camera following vars
follow = noone;
move_to_x = x;
move_to_y = y;

y_offset = 0;

// how fast the camera pans
camera_pan_speed_initial = 0.15; //lower = slowed pan
camera_pan_speed = 1;

//reset camera to default pan speed
alarm[CAMERA_RESET] = 3; //time counter to return the code to alarm event

//screen shake
screen_shake = false;
screen_shake_amount_initial = 3;
screen_shake_amount = screen_shake_amount_initial;

function on_options_change(_options = new OptionsModel())
{
	window_set_fullscreen(_options.fullscreen);
}

display_set_gui_size(_w * _scale, _h * _scale);
