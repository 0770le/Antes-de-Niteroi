event_inherited();

can_alert = false;
enemy_animation = harpia_anim;

hp = 4;

max_spd = 5;
acc = 0.2;
grav = 0;
dir = 0;

collision_dmg = false;

alert_distance = TILE_SIZE*7;
alert_initial_timer = room_speed * 2;
alert_timer = alert_initial_timer;

attack_cooldown = random_range(room_speed * 2.5 ,room_speed * 3.5);
attack_delay = attack_cooldown/2;

attack_prepare_initial_timer = room_speed * 0.6;
attack_prepare_timer = attack_prepare_initial_timer;

attack_hit_ground = false;
attack_recover_timer_initial = room_speed;
attack_recover_timer = attack_recover_timer_initial;

return_timer_initial = room_speed * 2;
return_timer = return_timer_initial

origin_x = 0;
origin_y = 0;

alarm[0] = 1;

die_sound_event = FMOD_EVENT.HARPIA_DIE;
hurt_sound_event = FMOD_EVENT.HARPIA_HURT;

//states
enum harpia_states {
	IDLE,
	HURTING,	
	CHASE,
	ATTACK,
	ATTACK_RECOVER,
	RETURN,
	OUT_OF_SCREEN
}

states_array[harpia_states.IDLE] = harpia_idle_state;
states_array[harpia_states.HURTING] = harpia_hurting_state;
states_array[harpia_states.CHASE] = harpia_chase_state;
states_array[harpia_states.ATTACK] = harpia_attack_state;
states_array[harpia_states.ATTACK_RECOVER] = harpia_attack_recover_state;
states_array[harpia_states.RETURN] = harpia_return_state;

sprites_array[harpia_states.IDLE] = s_harpia_idle;
sprites_array[harpia_states.HURTING] = s_harpia_move_forward;
sprites_array[harpia_states.CHASE] = s_harpia_move_forward;
sprites_array[harpia_states.ATTACK] = s_harpia_attack;
sprites_array[harpia_states.ATTACK_RECOVER] = s_harpia_move_back;
sprites_array[harpia_states.RETURN] = s_harpia_move_forward;

mask_array[harpia_states.IDLE] = s_harpia_move_back;
mask_array[harpia_states.HURTING] = s_harpia_move_back;
mask_array[harpia_states.CHASE] = s_harpia_move_back;
mask_array[harpia_states.ATTACK] = s_harpia_move_back;
mask_array[harpia_states.ATTACK_RECOVER] = s_harpia_move_back;
mask_array[harpia_states.RETURN] = s_harpia_move_back;

//to use on creation code in room
function set_harpia( _alert_distance = alert_distance, _alert_initial_timer = alert_initial_timer/room_speed ) {		
	alert_distance = _alert_distance;
	alert_initial_timer = _alert_initial_timer * room_speed;
}

layer = layer_get_id(LAYER_EFFECTS);

global.sound_controller.update_position_and_play(
	FMOD_EVENT.HARPIA_IDLE,
	x, y
);

function play_state_update_sounds(_previous_state, _new_state) {
	
	// on enter
	switch (_new_state)
	{
		case harpia_states.IDLE: 
			global.sound_controller.update_position_and_play(
				FMOD_EVENT.HARPIA_IDLE,
				x, y
			);
			break;
		case harpia_states.ATTACK: 
			global.sound_controller.update_position_and_play(
				FMOD_EVENT.HARPIA_ATTACK,
				x, y
			);
			break;
		case harpia_states.CHASE:
		case harpia_states.ATTACK_RECOVER:
			global.sound_controller.update_position_and_play(
				FMOD_EVENT.HARPIA_FLAP,
				x, y
			);
			break;
	}
	
	// on leave
	switch (_previous_state)
	{
		case harpia_states.IDLE: 
			global.sound_controller.stop(
				FMOD_EVENT.HARPIA_IDLE
			);
			break;
	}
	
	global.logger.debug($"Harpia previous state: {get_state_as_string(_previous_state)}, new state: {get_state_as_string(_new_state)}");
}

function get_state_as_string(_state)
{
	switch (_state)
	{
		case harpia_states.IDLE: return "IDLE";
		case harpia_states.HURTING: return "HURTING";
		case harpia_states.CHASE: return "CHASE";
		case harpia_states.ATTACK: return "ATTACK";
		case harpia_states.ATTACK_RECOVER: return "ATTACK_RECOVER";
		case harpia_states.RETURN: return "RETURN";
		case harpia_states.OUT_OF_SCREEN: return "OUT_OF_SCREEN";
		default: return "UNKNOWN";
	}
}

function process_wing_flap_sound()
{
	if (sprite_index == s_harpia_move_forward) {
		if (image_index == 2 || image_index == 4) {
			global.sound_controller.update_position_and_play(
				FMOD_EVENT.HARPIA_FLAP,
				x, y
			)
		}
	} else if (sprite_index == s_harpia_move_back) {
		if (image_index == 3) {
			global.sound_controller.update_position_and_play(
				FMOD_EVENT.HARPIA_FLAP,
				x, y
			)
		}
	}
}
