event_inherited();

enemy_animation = armadeira_anim;

//movement 
max_hsp_initial = 1;	//acelerado
chase_spd = max_hsp_initial*2.5;
max_vsp_initial = -1;	
spd = 0.5;
drag = 0.02;	
jump_vsp = -4;	
jump_hsp = 4;

hurt_time = room_speed * 1;
hp = 1;

alert_distance = 64;
alert_cooling = room_speed * 1.5;
//hide
hide_delay = room_speed * 3;

attack_cd = room_speed * random_range(3, 5); //emprestado como CD
damage = 1;

patrol_dis = random_range(40, 120);
//how long to wait before patrolling
wait_time_initial = room_speed * random_range(4, 10);


//states
enum armadeira_states {
	IDLE,
	WALK,
	CLIMB,
	ATTACK,
	JUMP,
	CHASE
}

states_array[enemy_states.IDLE] = armadeira_idle_state;
states_array[armadeira_states.WALK] = armadeira_walk_state;
states_array[armadeira_states.CLIMB] = armadeira_climb_state;
states_array[armadeira_states.ATTACK] = armadeira_attack_state;
states_array[armadeira_states.JUMP] = armadeira_jump_state;
states_array[armadeira_states.CHASE] = armadeira_chase_state;

sprites_array[armadeira_states.IDLE] = s_armadeira_idle;
sprites_array[armadeira_states.WALK] = s_armadeira_walk;
sprites_array[armadeira_states.CLIMB] = s_armadeira_climb;
sprites_array[armadeira_states.ATTACK] = s_armadeira_attack;
sprites_array[armadeira_states.JUMP] = s_armadeira_jump;
sprites_array[armadeira_states.CHASE] = s_armadeira_chase;


