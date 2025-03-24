function player_respawn() {
	
	var _last_room = global.options_controller.get_option(OPTIONS_LAST_ROOM);
	var _spawn_x = global.options_controller.get_option(OPTIONS_SPAWN_X);
	var _spawn_y = global.options_controller.get_option(OPTIONS_SPAWN_Y);
	
	room_goto(rm_cidade_velha);
	
	var _aux = {
		last_room: _last_room,
		spawn_x: _spawn_x,	
		spawn_y: _spawn_y,
		callback: function () {
			with(o_camera) {
				x = other.spawn_x;
				y = other.spawn_y;
			}
					
			with(o_player) {
				lives2 = global.options_controller.get_option(OPTIONS_PLAYER_LIVES);
				
				room_start_pos_x = other.spawn_x;
				room_start_pos_y = other.spawn_y;
						
				x = other.spawn_x;
				y = other.spawn_y;
						
				room_goto(other.last_room);
			}
		}
	}
		
	call_later(1, time_source_units_frames, _aux.callback);
}