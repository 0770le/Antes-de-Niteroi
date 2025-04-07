global.camera = self;
//get dimensions. modifica a info pega no camera

var _w		= GAME_W;
var _h		= GAME_H;
scale	= 3;

//create camera.(room_x, room_y, width, height, [angle, object, x_speed, y_speed, x_border, y_border])
window_set_size(_w * scale, _h * scale);

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

camera_created = false;

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

#region events
listeners = ds_map_create();
last_x = 0;
last_y = 0;
tolerance = 10;

function notify() 
{
	var _x = floor(global.cx+(global.cw/2));
	var _y = floor(global.cy+(global.ch/2));
	
	if (point_distance(_x, _y, last_x, last_y) > tolerance)
	{
		var _values = ds_map_values_to_array(listeners, []);
	
		for (var _i = 0; _i < array_length(_values); _i++) 
		{
			_values[_i].on_camera_update(_x, _y);
		}
		
		last_x = _x;
		last_y = _y;
	}
}

function subscribe(_listener)
{
	listeners[? _listener.id] = _listener;
}

function clear()
{
	ds_map_clear(listeners);
}

display_set_gui_size(_w * scale, _h * scale);

function create_camera() {
	camera = camera_create_view(0,0,GAME_W,GAME_H,0,-1,-1,-1,128,128 ) 
	view_set_camera(0, camera);
	camera_created = true;
}
