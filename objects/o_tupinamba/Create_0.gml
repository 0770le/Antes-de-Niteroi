event_inherited();

//BOW
//arrow spawning y pos
spawn_pos =1;
can_fire = true;
knockback_shoot_distance = 5;
fire_delay_initial = room_speed * random_range(3, 5);
fire_delay = fire_delay_initial;
number_of_shots_initial = 3;
number_of_shots = number_of_shots_initial;

//taking dmg
hurt_time = room_speed * 0.5;
hp = 3; 
flash_counter = 0;
//CASE check_enemy_hp flash dead generico
o_enemy = object_index;

//anim
enemy_animation = tupinamba_anim;

//alert
alert_distance = TILE_SIZE * 20;
alert_cooling = room_speed * random_range(3, 4);

//movement 
spd =  PLAYER_WALK_SPEED;		//"aceleração";
hsp = 0;
max_hsp_initial =  PLAYER_WALK_SPEED*0.8;
max_hsp =  PLAYER_MAX_HSP;
hsp_decimal = 0;
chase_spd = max_hsp;

vsp = 0;
vsp_decimal = 0;
//jump
jump_vsp = PLAYER_JUMP_SPEED+2;
jump_hsp = 4;


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
anim_duration = room_speed *.3;
//randon start to avoic sinc enemies
anim_start_initial = room_speed * random_range( 1.75, 2.25);
anim_start = anim_start_initial;
image_speed=0;

//avoid player arrow
evade_chance = 0.25;
evade_cd = room_speed;
evade_timer = evade_cd;

//patrol 
patrol = true;
patrol_left_limit = x - 130;
patrol_right_limit = x + 50;
patrol_destination = choose(-1,1);

//how long to wait before patrolling
wait_time_initial = random_range(4, 6) * room_speed;
wait_time = wait_time_initial;

//minimum distance to start chasing
chase_distance = alert_distance;	


//states
enum tupinamba_states {
	IDLE,
	SHOOT,
	PATROL,
	JUMP,
	HANGING,
	HURTING
}

//states
states_array[tupinamba_states.IDLE] = tupinamba_idle_state;
states_array[tupinamba_states.SHOOT] = tupinamba_shoot_state;
states_array[tupinamba_states.PATROL] = tupinamba_patrol_state;
states_array[tupinamba_states.JUMP] = tupinamba_jump_state;
states_array[tupinamba_states.HANGING] = tupinamba_hanging_state;
states_array[tupinamba_states.HURTING] = tupinamba_hurting_state;

sprites_array[tupinamba_states.IDLE] = s_tupinamba_idle;
sprites_array[tupinamba_states.SHOOT] = s_tupinamba_shoot;
sprites_array[tupinamba_states.PATROL] = s_tupinamba_patrol;
sprites_array[tupinamba_states.JUMP] = s_tupinamba_jump;
sprites_array[tupinamba_states.HANGING] = s_tupinamba_hanging;
sprites_array[tupinamba_states.HURTING] = s_tupinamba_hurting;

mask_array[tupinamba_states.IDLE] = s_tupinamba_idle;
mask_array[tupinamba_states.SHOOT] = s_tupinamba_idle;
mask_array[tupinamba_states.PATROL] = s_tupinamba_idle;
mask_array[tupinamba_states.JUMP] = s_tupinamba_idle;
mask_array[tupinamba_states.HANGING] = s_tupinamba_idle;
mask_array[tupinamba_states.HURTING] = s_tupinamba_idle;

function create_arrow() {
	//gap in frames 
		runned_once = true;
		alarm[ONCE] = room_speed*0.2;
	//set spawn position		
		ypos = -22;
	//create arrow
		var inst = instance_create_layer(side()+4*facing,y + ypos, "Arrow_shoot", o_tupinamba_rising_arrow);
		inst.facing = facing;
	//sound
		audio_play_sound(snd_arrow_firing,10, false, global.volume);
	//create spark
		var inst = instance_create_layer (side()+4*facing, y + ypos, "Arrow_shoot", o_arrow_spark);			
		inst.image_xscale = facing;
	//shot round		
		number_of_shots -= choose(1,2,3);	
		
}


//puff of smoke on spawn
//if (room == rm_02) {
//	alarm[SPAWN]=1;
//}

