event_inherited();

can_alert = false;
enemy_animation = jararaca_anim;
tongue = false;//alarme intervalo entre linguinhas
licking = false;//alarme tempo lambendo
can_zoomie = true; //alarm agitação


hurt_time = room_speed * 1;
hp = 1;

alert_distance = 40;

attack_cd = room_speed * random_range(5,6); //emprestado como CD
damage = 1;

//how long to wait before patrolling
wait_time_initial = room_speed * random_range(4, 6);

//movement 
max_hsp_initial = 5;	//acelerado
max_vsp_initial = -max_hsp_initial;	
spd = 0.8;
drag = 0.12;	

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

states_array[enemy_states.IDLE] = jararaca_idle_state;
states_array[jararaca_states.MOVING] = jararaca_moving_state;
states_array[jararaca_states.CLIMB] = jararaca_climb_state;
states_array[jararaca_states.DESCEND] = jararaca_descend_state;
states_array[jararaca_states.START_CLIMB] = jararaca_start_climb_state;
states_array[jararaca_states.STOP_CLIMB] = jararaca_stop_climb_state;
states_array[jararaca_states.START_DESCEND] = jararaca_start_descend_state;
states_array[jararaca_states.STOP_DESCEND] = jararaca_start_descend_state;


sprites_array[jararaca_states.IDLE] = s_jararaca_idle;
sprites_array[jararaca_states.MOVING] = s_jararaca_moving;
sprites_array[jararaca_states.CLIMB] = s_jararaca_climb;
sprites_array[jararaca_states.DESCEND] = s_jararaca_descend;
sprites_array[jararaca_states.START_CLIMB] = s_jararaca_climb_start;
sprites_array[jararaca_states.STOP_CLIMB] = s_jararaca_climb_stop;
sprites_array[jararaca_states.START_DESCEND] = s_jararaca_descend_start;
sprites_array[jararaca_states.STOP_DESCEND] = s_jararaca_descend_stop;


function snake_gear() {
	
	var gear_spd = spd;

	spd_array[jararaca_spds.TOP]	=	max_hsp_initial;
	spd_array[jararaca_spds.FAST]	=	spd * 1.4;
	spd_array[jararaca_spds.MID]	=	spd;
	spd_array[jararaca_spds.SLOW]	=	spd * 0.3;

	
	//se move rapido perto do player
	if ((distance_to_object(o_player) < alert_distance) and (o_player.hp > 0)) and !o_player.hidden {
		//speed up
		gear_spd = spd_array[jararaca_spds.TOP];
		//speed cooler
		wait_time = room_speed * random_range(0,0.7);
	
		//se tiver (diferente de idle ou pode atacar) E pode zoomie 
		if ((state != jararaca_states.IDLE or can_attack) and can_zoomie) { 
			//intervalo
			can_zoomie = false;
			alarm[8] = room_speed* 4;
			audio_play_sound(snd_bug_sees_player, 40, false, global.volume);
		}
	} 
}

function snake_hide() {
	if (distance_to_object(o_player) < alert_distance * 6) {
		//player para de ver se estiver longe
		hidden = false;
	} else {
		hidden=true;
	}
}

