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
	evade = keyboard_check_pressed(ord("Q"));
	shoot = keyboard_check_pressed(ord("W"));
	shoot_held = keyboard_check(ord("W"));
	menu_start =keyboard_check_pressed(vk_escape);
	
	//controler input
	var _dev = 0;
	if gamepad_is_connected(_dev) {
	var _deadzone = 0.3;
	left = gamepad_axis_value(_dev, gp_axislh) < -_deadzone or left;
	right = gamepad_axis_value(_dev, gp_axislh) >_deadzone or right;
	up = gamepad_axis_value(_dev, gp_axislv) < -_deadzone or up;
	down = gamepad_axis_value(_dev, gp_axislv) >_deadzone or down;
	attack = gamepad_button_check_pressed(_dev, gp_face2) or attack ;
	attack_held = gamepad_button_check(_dev, gp_face2) or attack_held ;
	jump = gamepad_button_check_pressed(_dev, gp_face1) or jump;
	jump_held = gamepad_button_check(_dev, gp_face1) or jump_held;
	evade = gamepad_button_check(_dev, gp_shoulderr) or evade;
	shoot = gamepad_button_check_pressed(_dev, gp_face3) or shoot;
	shoot_held = gamepad_button_check(_dev, gp_face3) or shoot_held;
	menu_start = gamepad_button_check_pressed(_dev, gp_start) or menu_start;
	}
}
