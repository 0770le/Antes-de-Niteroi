event_inherited();

//hanging
hanging_time_initial = room_speed * 0.2;
hanging_time = hanging_time_initial;

//BOW
//arrow spawning y pos
spawn_pos =1;
can_fire = false;
knockback_shoot_distance = 5;
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
alert_distance = (TILE_SIZE*2) * 20;
alert_cooling = room_speed * random_range(3, 4);

//movement 
spd =  1;		//"aceleração";
hsp = 0;

max_hsp =  PLAYER_MAX_HSP;
hsp_decimal = 0;
chase_spd = max_hsp;

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
can_attack = false;
alarm[CAN_ATTACK] = room_speed* random_range(3,5);

//animation
attack = false;
anim_duration = room_speed *.3;
//randon start to avoic sinc enemies
anim_start_initial = room_speed * random_range( 1.75, 2.25);
anim_start = anim_start_initial;
image_speed=0;


//patrol 
patrol = true;
patrol_left_limit = x - 250;
patrol_right_limit = x + 250;
patrol_destination = choose(-1,1);

//how long to wait before patrolling
wait_time_initial = random_range(4, 6) * room_speed;
wait_time = wait_time_initial;

//minimum distance to start chasing
chase_distance = alert_distance;

hurt_sound_event = FMOD_EVENT.TUPI_ARCHER_HURT;
die_sound_event = FMOD_EVENT.TUPI_ARCHER_DIE;
//states
enum tupinamba_states {
	IDLE,
	HURTING,
	SHOOT,
	PATROL,
	JUMP,
	HANGING,
	EVADE

}

//states
states_array[enemy_states.IDLE] = tupinamba_idle_state;
states_array[enemy_states.HURTING] = tupinamba_hurting_state;
states_array[tupinamba_states.SHOOT] = tupinamba_shoot_state;
states_array[tupinamba_states.PATROL] = tupinamba_patrol_state;
states_array[tupinamba_states.JUMP] = tupinamba_jump_state;
states_array[tupinamba_states.HANGING] = tupinamba_hanging_state;
states_array[tupinamba_states.EVADE] = tupinamba_evade_state;


sprites_array[tupinamba_states.IDLE] = s_tupinamba_idle;
sprites_array[tupinamba_states.HURTING] = s_tupinamba_hurting;
sprites_array[tupinamba_states.SHOOT] = s_tupinamba_shoot;
sprites_array[tupinamba_states.PATROL] = s_tupinamba_walk;
sprites_array[tupinamba_states.JUMP] = s_tupinamba_jump;
sprites_array[tupinamba_states.HANGING] = s_tupinamba_hanging;
sprites_array[tupinamba_states.EVADE] = s_tupinamba_evade;


mask_array[tupinamba_states.IDLE] = s_tupinamba_idle;
mask_array[tupinamba_states.HURTING] = s_tupinamba_idle;
mask_array[tupinamba_states.SHOOT] = s_tupinamba_idle;
mask_array[tupinamba_states.PATROL] = s_tupinamba_idle;
mask_array[tupinamba_states.JUMP] = s_tupinamba_idle;
mask_array[tupinamba_states.HANGING] = s_tupinamba_idle;
mask_array[tupinamba_states.EVADE] = s_tupinamba_idle;


function can_evade() {	
	if (o_player.hp > 0 and has_evade and alert) {
		if (distance_to_object(o_player) < 60) {
			stare();	
			has_evade = false;
			can_take_dmg = false;
			evade_delay = room_speed* 3;
			y+= -1;
			launch(jump_vsp*0.4, 8, -1*facing);
			state = tupinamba_states.EVADE;
			
			//dust
			jump_dust();
			audio_play_sound(snd_jump, 15, false, global.volume);
		}
	} else {
		evade_delay--
		if on_ground() {
			can_take_dmg = true;
		}
		if evade_delay < 0 {
			has_evade = true;	
		}
	}
}



function create_arrow() {
	//set spawn position		
		ypos = -22;
	//create arrow
		var inst = instance_create_layer(side()+4*facing,y + ypos, LAYER_PROJECTILES, o_tupinamba_rising_arrow);
		inst.facing = facing;
	//sound
		audio_play_sound(snd_arrow_firing,10, false, global.volume);
	//create spark
		inst = instance_create_layer (side()+4*facing, y + ypos, LAYER_PROJECTILES, o_arrow_spark);			
		inst.image_xscale = facing;
		
}
