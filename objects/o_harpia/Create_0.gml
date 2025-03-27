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
function set_harpia( _alert_distance = alert_distance/TILE_SIZE , _alert_initial_timer = alert_initial_timer/room_speed ) {		
	alert_distance = _alert_distance * TILE_SIZE;
	alert_initial_timer = _alert_initial_timer * room_speed;
}

layer = layer_get_id(LAYER_EFFECTS);