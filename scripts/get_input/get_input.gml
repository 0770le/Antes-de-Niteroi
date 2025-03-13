///get_input();

//keyboard input
function get_input() {
	var _input = global.input_manager.get_in_game_input();
	
	left		= _input.left;
	right		= _input.right; 
	up			= _input.up;
	down		= _input.down;
		
	attack		= _input.attack;
	attack_held = _input.attack_held;
	jump		= _input.jump;
	jump_held	= _input.jump_held;
	evade		= _input.dodge;
	evade_held	= _input.dodge_held;
	shoot		= _input.bow_shot;	
	shoot_held	= _input.bow_shot_held;
		
	interact	= _input.interact;
}
