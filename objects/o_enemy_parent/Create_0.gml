///@desc criar Parent

//taking dmg

knockback_multiplier = 1;
unstoppable = false; 
hurt = false;
hurt_time = room_speed * 1.5;
hp = 1;
can_take_dmg = true; 
flash_counter = 0;
//CASE check_enemy_hp flash dead generico
o_enemy = object_index;

//aux
runned_once = false;

death_protection = false;


//PREENCHER MANUAl
enemy_animation = 0; //inimigo_anim;

//alert
can_alert = true;
alert = false;
alert_distance = 100;
alert_cooling = room_speed * random_range( 1.5, 3);

//movement 
grav = global.grav;
spd = 1;
hsp = 0;
max_hsp = 1;
hsp_decimal = 0;
chase_spd = max_hsp*1.3;
vsp = 0;
vsp_decimal = 0;

facing = -1;
drag = 0.12;

die_sound_event = FMOD_EVENT.SNAKE_DIE;
hurt_sound_event = FMOD_EVENT.SNAKE_HURT;

//loot
hp_drop_chance = 0.3;
death_gem_value =0;// 3;

//attack
collision_dmg = true;
damage = 1;
knockback_distance = 5;
can_attack = true;
attack_delay = room_speed;

//animation
attack = false;


	//CHANGE STATE 
//PATROL

//patrol start position
start_x = x;
start_y = y;

patrol_left_limit = x - 16;
patrol_right_limit = x + 16; 

//how long to wait before patrolling
wait_time_initial = 0;//random_range(0, 0) * room_speed;
wait_time = wait_time_initial;
	//CHASE
//target to move to
target_x = 0;
target_y = 0;

chase_right_limit = 6000;
chase_left_limit =  10;

	//HIDING
hidden= false;
hide_delay = 1.5 * room_speed;


//states
enum enemy_states {
	IDLE,
	HURTING
}

state = enemy_states.IDLE;
previous_state = state;

//states_array[enemy_states.IDLE] = intern_idle_state;

//sprites_array[enemy_states.IDLE] = s_intern_idle;

function death(){
	
}


//warden will be static enemies that when alerted within a small distance will never drop alert and will chase long distances 
function warden(_alert_distance = TILE_SIZE * 3, _chase_left_limit = x - TILE_SIZE * 100, _chase_right_limit = x + TILE_SIZE * 100 ) {
	patrol = false;
	chase_right_limit = _chase_right_limit;
	chase_left_limit = _chase_left_limit;
	
	alert_distance = _alert_distance; 
	alert_cooling = room_speed *60;
}

#region state change updates
function process_state_update(_previous_state, _new_state) {
	if (_previous_state != _new_state) {
		play_state_update_sounds(_previous_state, _new_state);
		
		previous_state = _new_state;
		
		//global.logger.debug($"process_state_update _previous_state: {get_state_as_string(_previous_state)}, _new_state: {get_state_as_string(_new_state)}");
	}
}

function get_state_as_string(_state) {
	switch (_state)
	{
		case tupinamba_states.IDLE: return "IDLE";
		case tupinamba_states.HURTING: return "HURTING";
		case tupinamba_states.SHOOT: return "SHOOT";
		case tupinamba_states.PATROL: return "PATROL";
		case tupinamba_states.JUMP: return "JUMP";
		case tupinamba_states.HANGING: return "HANGING";
		case tupinamba_states.EVADE: return "EVADE";
		default: return "Unknown";
	}
}

function play_state_update_sounds(_previous_state, _new_state) {

}
#endregion

//puff of smoke on spawn
//if (room == rm_02) {
//	alarm[SPAWN]=1;
//}

