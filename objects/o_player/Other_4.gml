/// @description Move to location

x = room_start_pos_x;
y = room_start_pos_y;

global.options_controller.set_option(OPTIONS_LAST_ROOM, int64(room));
global.options_controller.set_option(OPTIONS_SPAWN_X, x);
global.options_controller.set_option(OPTIONS_SPAWN_Y, y);
