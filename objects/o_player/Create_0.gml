

o_camera.y_offset = -80;

// speeds
hsp =0; //horizontal
vsp = 0; //vertical
//I want the enemy to be able to see this var
max_hsp = PLAYER_MAX_HSP;// = 2.3;
walk_spd = PLAYER_WALK_SPEED;// =0.3;

hsp_decimal = 0;
vsp_decimal =0;
jump_spd = PLAYER_JUMP_SPEED;
jump_dampner = 2.5; //'amortecedor' diminuidor do pulo
jumps = 0;
corpse = undefined;
death_protection = false;

//auxiliar
runned_once = false;

//evade
has_evade = true;
evade_delay = 0.5;
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
attack_delay = 0.1 * room_speed;
	//how long enemies get knocked back for when hit
knockback_time = room_speed /2;
knockback_dis = 4; //1.5;
attack_held_time = 0;

//bow
can_fire = true;
fire_delay = 0.0 * room_speed; //charging time -> sprites
arrows_max = 30;
arrows_initial = 30;
arrows = arrows_initial;
	//arrow spawning dir pos
spawn_pos = -1;
	
//gems
gems = 0;
gems_value = 50;

//set rm_00 start position
room_start_pos_x = 150;//65; //ter das outra rm em comment
room_start_pos_y = 390;//94;
room_start_facing = 1;

facing =- room_start_facing;

//hurt
flash_counter = 0;
hurt = false;
hurt_time = room_speed*1.5;
hp = 5;
max_hp = hp;
hp_losing = max_hp;


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
attack_held=0;
jump = 0;
evade = 0;
jump_held = 0;
shoot = 0;
shoot_held = 0;

has_bow = false;

//camera 
o_camera.follow = o_player;



//states
enum states {
	IDLE,		//0
	WALK,		//1
	JUMP,		//2
	ATTACK,		//3
	ATTACK_WALK,//4
	AIR_ATTACK,	//5
	AIR_ATTACK_END,
	EVADE,		//6
	CROUCH,		//7
	HIDE,		//8
	SHOOT,		//9
	SHOOT_UP,	//10
	HURTING,	//11
	HANGING,	//12
	DIE,		//13
	DIE_2,		//14
	GAME_END	//15
}

state = states.IDLE;

//create states array
states_array[states.IDLE]			= player_idle_state; 
states_array[states.WALK]			= player_walk_state;
states_array[states.JUMP]			= player_jump_state;
states_array[states.ATTACK]			= player_attack_state;
states_array[states.ATTACK_WALK]	= player_attack_walk_state;
states_array[states.AIR_ATTACK]		= player_air_attack_state_2;
states_array[states.AIR_ATTACK_END]	= player_air_attack_end_state;
states_array[states.EVADE]			= player_evade_state;
states_array[states.CROUCH]			= player_crouch_state;
states_array[states.HIDE]			= player_hide_state;
states_array[states.SHOOT]			= player_shoot_state;
states_array[states.SHOOT_UP]		= player_shoot_up_state;
states_array[states.HURTING]		= player_hurting_state;
states_array[states.HANGING]		= player_hanging_state;
states_array[states.DIE]			= player_die_state;
states_array[states.DIE_2]			= player_die_2_state;
states_array[states.GAME_END]		= player_game_end_state;


//create sprites array

sprites_array[states.IDLE]			 = s_player_idle; 
sprites_array[states.WALK]			 = s_player_walk;
sprites_array[states.JUMP]			 = s_player_jump;
sprites_array[states.ATTACK]		 = s_player_attack;
sprites_array[states.ATTACK_WALK]	 = s_player_attack_walk;
sprites_array[states.AIR_ATTACK]	 = s_player_air_attack;
sprites_array[states.AIR_ATTACK_END] = s_player_air_attack_end;
sprites_array[states.EVADE]			 = s_player_evade;
sprites_array[states.CROUCH]		 = s_player_crouch;
sprites_array[states.HIDE]			 = s_player_crouch;
sprites_array[states.SHOOT]			 = s_player_bow_shoot;
sprites_array[states.SHOOT_UP]		 = s_player_bow_shoot_up;
sprites_array[states.HURTING]		 = s_player_hurting;
sprites_array[states.HANGING]		 = s_player_hanging;
sprites_array[states.DIE]			 = s_player_die;
sprites_array[states.DIE_2]			 = s_player_die_2;
sprites_array[states.GAME_END]		 = s_player_die_2;

//create mask array

mask_array[states.IDLE]				= s_player_hitbox; 
mask_array[states.WALK]				= s_player_hitbox; 
mask_array[states.JUMP]				= s_player_hitbox; 
mask_array[states.ATTACK]			= s_player_hitbox; 
mask_array[states.ATTACK_WALK]		= s_player_hitbox; 
mask_array[states.AIR_ATTACK]		= s_player_hitbox; 
mask_array[states.AIR_ATTACK_END]		= s_player_hitbox; 
mask_array[states.EVADE]			= s_player_hitbox; 
mask_array[states.HIDE]				= s_player_hitbox_crouch;
mask_array[states.CROUCH]			= s_player_hitbox_crouch;
mask_array[states.SHOOT]			= s_player_hitbox;
mask_array[states.SHOOT_UP]			= s_player_hitbox;
mask_array[states.HURTING]			= s_player_hitbox;
mask_array[states.HANGING]			= s_player_hitbox;
mask_array[states.DIE]				= s_player_hitbox_crouch;
mask_array[states.DIE_2]			= s_player_hitbox_crouch;
mask_array[states.GAME_END]			= s_player_hitbox_crouch;


function acquire_bow() {
	has_bow = true;
	
	sprites_array[states.IDLE]			 = s_player_bow_idle; 
	sprites_array[states.WALK]			 = s_player_bow_walk;
	sprites_array[states.JUMP]			 = s_player_bow_jump;
	sprites_array[states.ATTACK]		 = s_player_bow_attack;
	sprites_array[states.ATTACK_WALK]	 = s_player_bow_attack_walk;
	sprites_array[states.AIR_ATTACK]	 = s_player_bow_air_attack;
	sprites_array[states.AIR_ATTACK_END] = s_player_bow_air_attack_end;
	sprites_array[states.EVADE]			 = s_player_bow_evade;
	sprites_array[states.CROUCH]		 = s_player_bow_crouch;
	sprites_array[states.HIDE]			 = s_player_bow_crouch;
	sprites_array[states.HURTING]		 = s_player_bow_hurting;
	sprites_array[states.HANGING]		 = s_player_bow_hanging;
	sprites_array[states.DIE]			 = s_player_bow_die;
	sprites_array[states.DIE_2]			 = s_player_bow_die_2;
	sprites_array[states.GAME_END]		 = s_player_bow_die_2;
}
