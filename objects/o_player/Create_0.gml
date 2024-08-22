
// speeds
hsp =0; //horizontal
vsp = 0; //vertical
max_hsp= 2.3;
walk_spd=0.3;

hsp_decimal = 0;
vsp_decimal =0;
jump_spd = -7;
jump_dampner = 2.5; //'amortecedor' diminuidor do pulo
jumps_initial = 1;
jumps = jumps_initial;

// fps pra multiplicar por tempo em segundos
// room_speed;

//evade
evade_v_spd = jump_spd/2;
evade_h_spd = max_hsp*4;
has_evade = true;
evade_delay = 0.8;
can_take_dmg = true;

//friction
drag=0.1;
//streching
scale_x= 1;
scale_y= 1;
scale_min= 0.75;
scale_max= 1.25;
scale_decay = 0.2;

//Hide
engaged = false;
hide_cover = false;
hide_ready = false
hide_delay = 0.6;
// stealth
hidden = false;

//curupira
curupira_count_max = 10;
curupira_count_initial = 0;
curupira_count = curupira_count_initial;
vines_max = 3;
vines_initial =0;
vines = vines_initial;
vine_ball_max = 1;
vine_ball_initial = 0;
vine_ball = vine_ball_initial;

//attack
dmg = 0;
can_attack = true;
attack_delay = 0.2 * room_speed;
	//how long enemies get knocked back for when hit
knockback_time = room_speed /2;
knockback_dis = 1.5;

enum attacks {
	NONE,
	LEAP,
	LUNGE,
	STRIKE,
	BLOW
}
attack_type = attacks.NONE;

//bow
can_fire = true;
fire_delay = 1 * room_speed; //charging time -> sprites
arrows_max = 9;
arrows_initial = 9;
arrows = arrows_initial;
	//arrow spawning y pos
spawn_pos = -1;
	
//gems
gems = 0;
gems_value = 50;

//set rm_00 start position
room_start_pos_x = 144;//65; //ter das outra rm em comment
room_start_pos_y = 280;//94;
room_start_facing = 1;
x = room_start_pos_x;
y = room_start_pos_y;
facing =- room_start_facing;

//hurt
flash_counter = 0;
hurt = false;
hurt_time = room_speed;
hp = 5;
max_hp = hp;


//lives
lives_initial = 3;
lives = lives_initial;
lives_value = 1000;

//contrl movement
left =0;
right = 0;
up= 0;
down=0;
attack=0;
jump = 0;
evade = 0;
jump_held = 0;
shoot = 0;

//camera 
o_camera.follow = o_player;



//states
enum states {
	IDLE,		//0
	WALK,		//1
	JUMP,		//2
	ATTACK,		//3
	EVADE,		//4
	CROUCH,		//5
	HIDE,		//6
	SHOOT,		//7
	HURTING,	//8
	HANGING,	//9
	DIE,		//10
	//LOCKED alarm LOCK
	GAME_END	//11
}

state = states.IDLE;

//create states array
states_array[states.IDLE]			= player_idle_state; 
states_array[states.WALK]			= player_walk_state;
states_array[states.JUMP]			= player_jump_state;
states_array[states.ATTACK]			= player_attack_state;
states_array[states.EVADE]			= player_evade_state;
states_array[states.CROUCH]			= player_crouch_state;
states_array[states.HIDE]			= player_hide_state;
states_array[states.SHOOT]			= player_shoot_state;
states_array[states.HURTING]		= player_hurting_state;
states_array[states.HANGING]		= player_hanging_state;
states_array[states.DIE]			= player_die_state;
states_array[states.GAME_END]		= player_game_end_state;


//create sprites array

sprites_array[states.IDLE]			 = s_player_idle; 
sprites_array[states.WALK]			 = s_player_walk;
sprites_array[states.JUMP]			 = s_player_jump;
sprites_array[states.ATTACK]		 = s_player_attack;
sprites_array[states.EVADE]			 = s_player_evade;
sprites_array[states.CROUCH]		 = s_player_crouch;
sprites_array[states.HIDE]			 = s_player_hide;
sprites_array[states.SHOOT]			 = s_player_shoot;
sprites_array[states.HURTING]		 = s_player_hurting;
sprites_array[states.HANGING]		 = s_player_hanging;
sprites_array[states.DIE]			 = s_player_die;
sprites_array[states.GAME_END]		 = s_player_die;

//create mask array

mask_array[states.IDLE]				= s_player_idle; 
mask_array[states.WALK]				= s_player_idle; 
mask_array[states.JUMP]				= s_player_idle; 
mask_array[states.ATTACK]			= s_player_idle; 
mask_array[states.EVADE]			= s_player_idle; 
mask_array[states.HIDE]				= s_player_crouch;
mask_array[states.CROUCH]			= s_player_crouch;
mask_array[states.SHOOT]			= s_player_idle;
mask_array[states.HURTING]			= s_player_idle;
mask_array[states.HANGING]			= s_player_idle;
mask_array[states.DIE]				= s_player_die;
mask_array[states.GAME_END]			= s_player_die;



