event_inherited();

can_alert = false;
enemy_animation = jararaca_anim;
tongue = false;//alarme intervalo lambida
licking = false;//alarme tempo lambendo
can_noise = true; //alarm gritinho


hurt_time = room_speed * 1;
hp = 1;

alert_distance = 20;

attack_delay = room_speed * random_range(8,9);
damage = 1;

//how long to wait before patrolling
wait_time_initial = room_speed * random_range(5, 9);

//movement 
max_hsp_initial = 4;	//acelerado
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
//sistema de spds no step
gear_spd = spd;

spd_array[jararaca_spds.TOP]	=	max_hsp_initial;
spd_array[jararaca_spds.FAST]	=	spd * 1.4;
spd_array[jararaca_spds.MID]	=	spd;
spd_array[jararaca_spds.SLOW]	=	spd * 0.3;



//states
enum jararaca_states {
	IDLE,
	MOVING,
	CLIMB
}

states_array[enemy_states.IDLE] = jararaca_idle_state;
states_array[jararaca_states.MOVING] = jararaca_moving_state;
states_array[jararaca_states.CLIMB] = jararaca_climb_state;


sprites_array[jararaca_states.IDLE] = s_jararaca_idle;
sprites_array[jararaca_states.MOVING] = s_jararaca_moving;
sprites_array[jararaca_states.CLIMB] = s_jararaca_climb;




