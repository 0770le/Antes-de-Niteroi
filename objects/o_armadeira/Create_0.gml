event_inherited();

enemy_animation = armadeira_anim;

//movement 
chase_spd = 1.4;

death_protection = true;

spd_min_limit = 0.1;
spd_max_limit = 0.4;

spd = random_range(spd_min_limit, spd_max_limit);
drag = 0.01;	
grav = global.grav*0.5;


hurt_time = room_speed * 1;
hp = 1;

alert_distance = random_range ((TILE_SIZE*2)*1.5, (TILE_SIZE*2)*2.2);
alert_cooling = room_speed * 1.5;
//hide
hide_delay = room_speed * 1;

attack_cd = room_speed * random_range(0, 0); //emprestado como CD
damage = 1;

//PATROL
patrol_dis = 100;
patrol_min_dis =20;
patrol_max_dis =120;

patrol_dis = random_range(patrol_min_dis, patrol_max_dis);
//how long to wait before patrolling
wait_time_initial = room_speed * random_range(2.5, 7);
wait_time = wait_time_initial;

agressive_timer = room_speed * random_range(1.5, 3);

//states
enum armadeira_states {
	IDLE,	//0
	WALK,	//1
	CLIMB,	//2
	ATTACK,	//3
	JUMP,	//4
	CHASE,	//5
	OUT_OF_SCREEN
}

die_sound_event = FMOD_EVENT.SPIDER_DIE;
hurt_sound_event = FMOD_EVENT.SPIDER_HURT;

states_array[armadeira_states.IDLE] = armadeira_idle_state;
states_array[armadeira_states.WALK] = armadeira_walk_state;
states_array[armadeira_states.CLIMB] = armadeira_climb_state;
states_array[armadeira_states.ATTACK] = armadeira_attack_state;
states_array[armadeira_states.JUMP] = armadeira_jump_state;
states_array[armadeira_states.CHASE] = armadeira_chase_state;
states_array[armadeira_states.OUT_OF_SCREEN] = armadeira_out_of_screen_state;

sprites_array[armadeira_states.IDLE] = s_armadeira_idle;
sprites_array[armadeira_states.WALK] = s_armadeira_walk;
sprites_array[armadeira_states.CLIMB] = s_armadeira_climb;
sprites_array[armadeira_states.ATTACK] = s_armadeira_attack;
sprites_array[armadeira_states.JUMP] = s_armadeira_jump;
sprites_array[armadeira_states.CHASE] = s_armadeira_chase;
sprites_array[armadeira_states.OUT_OF_SCREEN] = s_armadeira_idle;


function on_ceeling(){

	var t1 = tilemap_get_at_pixel(global.map, side(), bbox_top -1);
	var t2 = tilemap_get_at_pixel(global.map, side(false), bbox_top -1);
	
	if  (t1 == SOLID or t2 == SOLID) 
		return true else return false;
		
}