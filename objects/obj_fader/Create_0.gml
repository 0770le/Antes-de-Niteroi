global.fader = self;

// settings

transition_period_max = 120;
pivot_balance = 0.5;
alpha_max = 1.4;

// controls

transition_period = 0;
alpha = 0;
is_active = false;

// others 

spawn_x = 0;
spawn_y = 0;
facing = 0;
spawn_room = rm_cidade_velha;

end_game = false;

function to_room(
	_spawn_room = rm_cidade_velha, 
	_spawn_x = 0, 
	_spawn_y = 0,
	_end_game = false
) {
	if (!is_active)
	{
		spawn_x = _spawn_x;
		spawn_y = _spawn_y;
		spawn_room = _spawn_room;
		
		end_game = _end_game;
	
		transition_period = transition_period_max;
	}
}

function load_respawn_data() { // the player will call it during creation
	var _lives = global.options_controller.get_option(OPTIONS_PLAYER_LIVES);
	var _hp = global.options_controller.get_option(OPTIONS_PLAYER_HP);
	var _died = global.options_controller.get_option(OPTIONS_PLAYER_DIED);
	var _arrows = global.options_controller.get_option(OPTIONS_PLAYER_ARROWS);
	var _facing = global.options_controller.get_option(OPTIONS_PLAYER_FACING);
		
	global.player.lives2 = _lives;
	global.player.hp = _died ? o_game.max_hp : _hp;
	global.player.arrows = _arrows;
	global.player.facing = _facing;
		
	if (spawn_x > 0 && spawn_y > 0)
	{
		global.player.room_start_pos_x = spawn_x;
		global.player.room_start_pos_y = spawn_y;
	
		global.player.x = spawn_x;
		global.player.y = spawn_y;
	}
}

function __prepare_room() {
	room_goto(spawn_room);
	
	if (spawn_x > 0 && spawn_y > 0) {
		global.camera.x = spawn_x;
		global.camera.y = spawn_y;
	}
}

function __step() {
	var _pivot = transition_period_max * pivot_balance;
	
	if (transition_period > _pivot) {
		alpha = ((transition_period_max - transition_period) / _pivot)*alpha_max;
	} else if (transition_period == _pivot) {
		if(!end_game) {
			__prepare_room();
		} else {
			room_goto(rm_ending);
			end_game = false;
		}
	} else if (transition_period < _pivot) {
		alpha = (transition_period / _pivot)*alpha_max;
	}
	
	transition_period = max(0, transition_period - 1);
	alpha = clamp(alpha, 0, 1);
	
	is_active = transition_period > 0;
}

function __draw() {
	if (alpha <= 0) return;
	
	draw_set_color(c_black);
	draw_set_alpha(alpha);
	
	//multiplying by 2 due to some bug
	var _xx = window_get_width()*2;
	var _yy = window_get_height()*2;
	
	draw_rectangle(0, 0, _xx, _yy, false);
	
	draw_set_alpha(1);
}