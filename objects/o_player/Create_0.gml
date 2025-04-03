global.player = self;

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
last_walk_index = 0;

//evade
has_evade = true;
evade_delay = room_speed * 0.5;
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

////curupira
//curupira_count_max = 10;
//curupira_count_initial = 0;
//curupira_count = curupira_count_initial;
//vines_max = 3;
//vines_initial =0;
//vines = vines_initial;
//vine_ball_max = 1;
//vine_ball_initial = 0;
//vine_ball = vine_ball_initial;

//attack
dmg = 0;
can_attack = true;
	//how long enemies get knocked back for when hit
knockback_time = room_speed /2;
knockback_dis = 4; //1.5;
attack_held_time = 0;
power_attack = false;
attack_aura = noone;

//bow
can_fire = true;
fire_delay = 0.1 * room_speed; //charging time -> sprites
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
hurt_time = room_speed*0.8;
hp = o_game.max_hp;
//max_hp = hp;
hp_losing = hp;

//lives
lives_initial = 3;
lives = lives_initial;

// ********* Atenção ! ********* 
//
// coloquei essa variavel lives2 porque o GM nao estava deixando 
// eu pegar o_player.lives de jeito nenhum
// 
lives2 = lives_initial; 


//contrl movement
left = 0;
right = 0;
up= 0;
down= 0;
attack=0;
attack_held=0;
jump = 0;
evade = 0;
jump_held = 0;
shoot = 0;
shoot_held = 0;



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

function update_save() {
	global.options_controller.set_options({
		OPTIONS_LAST_ROOM: int64(room),
		OPTIONS_SPAWN_X: x,
		OPTIONS_SPAWN_Y: y,
		OPTIONS_PLAYER_LIVES: lives2,
		OPTIONS_PLAYER_HP: hp,
		OPTIONS_PLAYER_DIED: false
	});
}

function update_saved_hp() {
	if (global.options_controller.get_option(OPTIONS_PLAYER_HP) != hp) {
		global.options_controller.set_option(OPTIONS_PLAYER_HP, hp);
	}
}

function draw_lives() {
	var _xx = 10;
	var _yy = 400;
	var _lives_label = $"x{lives2}";

	draw_set_valign(fa_top);
	draw_set_halign(fa_left);
	draw_set_font(fnt_arial_medium);

	// draw shadow
	draw_set_color(c_black);

	draw_text(_xx - 1, _yy - 1, _lives_label);
	draw_text(_xx - 1, _yy + 1, _lives_label);
	draw_text(_xx + 1, _yy - 1, _lives_label);
	draw_text(_xx + 1, _yy + 1, _lives_label);

	// draw text
	draw_set_color(c_orange);
	draw_text(_xx, _yy, _lives_label);
}

function play_state_change_sounds(_previous_state, _current_state)
{
	if (_previous_state == _current_state) return;
	
	//global.logger.debug($"play_state_change_sounds _previous_state: {get_state_as_string(_previous_state)}, _current_state: {get_state_as_string(_current_state)}")
	
	// on enter state
	switch (_current_state) {
		case states.SHOOT:
		case states.SHOOT_UP:
			global.sound_controller.update_event_parameter_and_play_pos(FMOD_EVENT.ATTACK_BOW, FMOD_PARAMETER_NAME_MOVE, FMOD_PARAMETER_ATTACK_BOW_VALUE.PREPARE, x, y);
			break;
		case states.JUMP:
			if (vsp < 0) {
				global.sound_controller.update_event_parameter_and_play_pos(FMOD_EVENT.JUMP, FMOD_PARAMETER_NAME_MOVE, FMOD_PARAMETER_MOVE_JUMP.JUMP, x, y);
			}
			break;
		case states.HANGING:
			global.sound_controller.play_pos(FMOD_EVENT.HANG, x, y);
			break;
		default:
	}
	
	// on leave state
	switch (_previous_state) {
		case states.SHOOT:
		case states.SHOOT_UP:
			global.sound_controller.update_event_parameter_and_play_pos(FMOD_EVENT.ATTACK_BOW, FMOD_PARAMETER_NAME_MOVE, FMOD_PARAMETER_ATTACK_BOW_VALUE.RELEASE, x, y);
			break;
		case states.CROUCH:
			// do nothing
			break;
		case states.JUMP:
			global.sound_controller.update_event_parameter_and_play_pos(FMOD_EVENT.JUMP, FMOD_PARAMETER_NAME_MOVE, FMOD_PARAMETER_MOVE_JUMP.LAND, x, y);
			break;
		case states.AIR_ATTACK:
		case states.ATTACK:
			global.sound_controller.stop(FMOD_EVENT.ATTACK_MELEE);
			break;
		case states.HANGING:
			global.sound_controller.stop(FMOD_EVENT.HANG);
			break;
		default:
	}
	
	// both states
	
}

function get_state_as_string(_state)
{
	switch (_state)
	{
		case states.IDLE: return "IDLE";
		case states.WALK: return "WALK";
		case states.JUMP: return "JUMP";
		case states.ATTACK: return "ATTACK";
		case states.ATTACK_WALK: return "ATTACK_WALK";
		case states.AIR_ATTACK: return "AIR_ATTACK";
		case states.AIR_ATTACK_END: return "AIR_ATTACK_END";
		case states.EVADE: return "EVADE";
		case states.CROUCH: return "CROUCH";
		case states.HIDE: return "HIDE";
		case states.SHOOT: return "SHOOT";
		case states.SHOOT_UP: return "SHOOT_UP";
		case states.HURTING: return "HURTING";
		case states.HANGING: return "HANGING";
		case states.DIE: return "DIE";
		case states.DIE_2: return "DIE_2";
		case states.GAME_END: return "GAME_END";
		default: return "UNKNOWN";
	}
}

if (o_game.has_bow) {
	acquire_bow();
}
