event_inherited();

can_alert = false;
enemy_animation = jararaca_anim;
tongue = false;//alarme intervalo entre linguinhas
licking = false;//alarme tempo lambendo
can_zoomie = true; //alarm agitação

drag = 0;

hurt_time = room_speed * 1;
hp = 2;

alert_distance = 80;

death_protection = true;

attack_cd = room_speed * random_range(5,6); //emprestado como CD
damage = 1;

wall_x = 0;
wall_y = 0;

//how long to wait before patrolling
wait_time_initial = room_speed * random_range(4, 6);

patrol_left_limit = 10;
patrol_right_limit = 10000; 

idle_move_timer = room_speed * random_range(5, 9);

//movement 


spd = 0.8;
drag = 0.12;

spd_array[jararaca_spds.TOP]	=	4.5;
 spd_array[jararaca_spds.FAST]	=	2;
 spd_array[jararaca_spds.MID]	=	1;
spd_array[jararaca_spds.SLOW]	=	0.2;

img_spd_array[jararaca_spds.TOP]	=	2;
img_spd_array[jararaca_spds.FAST]	=	1.5;
img_spd_array[jararaca_spds.MID]	=	1;
img_spd_array[jararaca_spds.SLOW]	=	0.1;

//speeds
enum jararaca_spds {
	TOP,
	FAST,
	MID,
	SLOW
}

//states
enum jararaca_states {
	IDLE,
	MOVING,
	CLIMB,
	DESCEND,
	START_CLIMB,
	STOP_CLIMB,
	START_DESCEND,
	STOP_DESCEND
}

die_sound_event = FMOD_EVENT.SNAKE_DIE;
hurt_sound_event = FMOD_EVENT.SNAKE_HURT;

states_array[enemy_states.IDLE] = jararaca_idle_state;
states_array[jararaca_states.MOVING] = jararaca_moving_state;
states_array[jararaca_states.CLIMB] = jararaca_climb_state;
states_array[jararaca_states.DESCEND] = jararaca_descend_state;
states_array[jararaca_states.START_CLIMB] = jararaca_start_climb_state;
states_array[jararaca_states.STOP_CLIMB] = jararaca_stop_climb_state;
states_array[jararaca_states.START_DESCEND] = jararaca_start_descend_state;
states_array[jararaca_states.STOP_DESCEND] = jararaca_stop_descend_state;


sprites_array[jararaca_states.IDLE] = s_jararaca_idle;
sprites_array[jararaca_states.MOVING] = s_jararaca_moving;
sprites_array[jararaca_states.CLIMB] = s_jararaca_climb;
sprites_array[jararaca_states.DESCEND] = s_jararaca_descend;
sprites_array[jararaca_states.START_CLIMB] = s_jararaca_climb_start;
sprites_array[jararaca_states.STOP_CLIMB] = s_jararaca_climb_stop;
sprites_array[jararaca_states.START_DESCEND] = s_jararaca_descend_start;
sprites_array[jararaca_states.STOP_DESCEND] = s_jararaca_descend_stop;



function snake_gear() {
	
	//se move rapido perto do player
	if (can_zoomie and (distance_to_object(o_player) < alert_distance) and (o_player.hp > 0) and !o_player.hidden) {
		//speed up
		
		spd = spd_array[jararaca_spds.TOP];
		image_speed = img_spd_array[jararaca_spds.TOP];
		
		//speed cooler
		alarm[7] = room_speed * random_range(0.1,1);
	
		//se tiver (diferente de idle ou pode atacar) E pode zoomie 
		if (state == jararaca_states.IDLE) { 
			state = jararaca_states.MOVING;
		}
	} 
}

function snake_hide() {
	if (distance_to_object(o_player) < TILE_SIZE * 7) {
		//player para de ver se estiver longe
		hidden = false;
	} else {
		hidden=true;
	}
}

