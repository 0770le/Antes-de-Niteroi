event_inherited();

turret = false;

duck_time_initial = room_speed * 0.8;
duck_time = duck_time_initial;

//BOW
//arrow spawning y pos
spawn_pos =1;
can_fire = false;
knockback_shoot_distance = 5;
fire_delay_initial = room_speed * random_range(3, 5);
fire_delay = fire_delay_initial;


//taking dmg
hurt_time = room_speed * 0.5;
hp = 3; 
flash_counter = 0;
//CASE check_enemy_hp flash dead generico
o_enemy = object_index;

//anim
enemy_animation = frances_anim;

//alert
alert_distance = (TILE_SIZE*2) * 20;
alert_cooling = room_speed * random_range(3, 4);

//movement 
spd =  PLAYER_WALK_SPEED;		//"aceleração";
hsp = 0;

max_hsp =  PLAYER_MAX_HSP;
hsp_decimal = 0;
chase_spd = max_hsp*1.3;

vsp = 0;
vsp_decimal = 0;
//jump
jump_vsp = PLAYER_JUMP_SPEED+1;
jump_hsp = 4;
//evade
has_evade = true;
evade_delay = room_speed* 3;

//loot
hp_drop_chance = 0.3;
arrow_drop_chance = 0.3;

//actions
//attack
collision_dmg = false;
damage = 1;
knockback_distance = 5;
can_attack = true;
attack_delay = room_speed;
//animation
attack = false;

//patrol 
patrol = true;
patrol_left_limit = x - 130;
patrol_right_limit = x + 50;
patrol_destination = choose(-1,1);

//how long to wait before patrolling
wait_time_initial = random_range(4, 6) * room_speed;
wait_time = wait_time_initial;


die_sound_event = FMOD_EVENT.FRENCH_SHOOTER_DIE;
hurt_sound_event = FMOD_EVENT.FRENCH_SHOOTER_HURT;

//states
enum frances_states {
	IDLE,
	HURTING,
	SHOOT,
	PATROL,
	JUMP,
	RELOAD,
	DUCK,
	RUN

}

//states
states_array[enemy_states.IDLE] = frances_idle_state;
states_array[enemy_states.HURTING] = frances_hurting_state;
states_array[frances_states.SHOOT] = frances_shoot_state;
states_array[frances_states.PATROL] = frances_patrol_state;
states_array[frances_states.JUMP] = frances_jump_state;
states_array[frances_states.RELOAD] = frances_reload_state;
states_array[frances_states.DUCK] = frances_duck_state;
states_array[frances_states.RUN] = frances_run_state;


sprites_array[frances_states.IDLE] = s_frances_idle;
sprites_array[frances_states.HURTING] = s_frances_hurting;
sprites_array[frances_states.SHOOT] = s_frances_shoot;
sprites_array[frances_states.PATROL] = s_frances_walk;
sprites_array[frances_states.JUMP] = s_frances_jump;
sprites_array[frances_states.RELOAD] = s_frances_reload;
sprites_array[frances_states.DUCK] = s_frances_duck;
sprites_array[frances_states.RUN] = s_frances_run;


mask_array[frances_states.IDLE] = s_frances_idle;
mask_array[frances_states.HURTING] = s_frances_idle;
mask_array[frances_states.SHOOT] = s_frances_duck;
mask_array[frances_states.PATROL] = s_frances_idle;
mask_array[frances_states.JUMP] = s_frances_idle;
mask_array[frances_states.RELOAD] = s_frances_idle;
mask_array[frances_states.DUCK] = s_frances_duck;
mask_array[frances_states.RUN] = s_frances_idle;


function create_bullet() {
	if(line_of_sight() and collision_line(x, y-10, x + facing * GAME_W, y-10,o_player, false, true)) {
		with(o_player) {
			process_enemy_attack();	
		}
	}
}

state = frances_states.IDLE;
