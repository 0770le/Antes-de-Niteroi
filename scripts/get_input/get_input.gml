///get_input();

//keyboard input
function get_input() {
	left = keyboard_check(vk_left);// or keyboard_check(ord("A"));
	right = keyboard_check(vk_right);// or keyboard_check(ord("D"));
	up = keyboard_check(vk_up);// or keyboard_check(ord("W"));
	down = keyboard_check(vk_down); // or keyboard_check(ord("S"));
	attack =keyboard_check_pressed(ord("E"));
	attack_held = keyboard_check(ord("E"));
	jump = keyboard_check_pressed(vk_space);
	jump_held = keyboard_check(vk_space);
	evade = keyboard_check(ord("Q"));
	shoot = keyboard_check_pressed(ord("W"));
	shoot_held = keyboard_check(ord("W"));
	menu_start =keyboard_check_pressed(vk_escape);
	
	//controler input
	var _dev = 0;
	if (gamepad_is_connected(_dev)) 
	{
		var _input = global.input_manager.get_in_game_input();
		
		left		= _input.left	or left;
		right		= _input.right  or right;
		up			= _input.up		or up;
		down		= _input.down	or down;
		
		attack		= _input.attack			or attack;
		attack_held = _input.attack_held	or attack_held;
		jump		= _input.jump			or jump;
		jump_held	= _input.jump_held		or jump_held;
		evade		= _input.dodge			or evade;
		evade_held	= _input.dodge_held		or evade;
		shoot		= _input.bow_shot		or shoot;
		shoot_held	= _input.bow_shot_held	or shoot_held;
		
		interact	= _input.interact		or up;
		
		// menu_start	= gamepad_button_check_pressed(_dev, gp_start) or menu_start;
	}
}
