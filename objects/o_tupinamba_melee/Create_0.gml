event_inherited();


//taking dmg
hurt_time = room_speed * 0.5;
hp = 3; 
flash_counter = 0;
//CASE check_enemy_hp flash dead generico
o_enemy = object_index;

//anim
enemy_animation = tupinamba_melee_anim;

//alert
alert_distance = TILE_SIZE * 20;
alert_cooling = room_speed * random_range(3, 4);

//movement 
spd =  PLAYER_WALK_SPEED;		//"aceleração";
hsp = 0;
max_hsp_initial =  PLAYER_WALK_SPEED*0.8;
max_hsp =  PLAYER_MAX_HSP*0.9;
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
knockback_distance = 8;
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

evade_cd = room_speed;
evade_timer = evade_cd;

//patrol 
patrol = true;
patrol_left_limit = x - 300;
patrol_right_limit = x + 50;
patrol_destination = choose(-1,1);

//how long to wait before patrolling
wait_time_initial = random_range(4, 6) * room_speed;
wait_time = wait_time_initial;

//minimum distance to start chasing
chase_distance = alert_distance;	


//states
enum tupinamba_melee_states {
	IDLE,			//0
	HURTING,		//1
	ATTACK,			//2
	PATROL,
	JUMP,
	HANGING,
	EVADE

}

//states
states_array[enemy_states.IDLE] = tupinamba_melee_idle_state;
states_array[enemy_states.HURTING] = tupinamba_melee_hurting_state;

states_array[tupinamba_melee_states.ATTACK] = tupinamba_melee_attack_state;
states_array[tupinamba_melee_states.PATROL] =tupinamba_melee_patrol_state;
states_array[tupinamba_melee_states.JUMP] = tupinamba_melee_jump_state;
states_array[tupinamba_melee_states.HANGING] = tupinamba_melee_hanging_state;
states_array[tupinamba_melee_states.EVADE] = tupinamba_melee_evade_state;


sprites_array[tupinamba_melee_states.IDLE] = s_tupinamba_melee_idle;
sprites_array[tupinamba_melee_states.HURTING] = s_tupinamba_hurting;

sprites_array[tupinamba_melee_states.ATTACK] = s_tupinamba_melee_attack;
sprites_array[tupinamba_melee_states.PATROL] = s_tupinamba_patrol;
sprites_array[tupinamba_melee_states.JUMP] = s_tupinamba_jump;
sprites_array[tupinamba_melee_states.HANGING] = s_tupinamba_hanging;
sprites_array[tupinamba_melee_states.EVADE] = s_tupinamba_evade;


mask_array[tupinamba_melee_states.IDLE] = s_tupinamba_melee_idle;
mask_array[tupinamba_melee_states.HURTING] = s_tupinamba_melee_idle;

mask_array[tupinamba_melee_states.ATTACK] = s_tupinamba_melee_idle;
mask_array[tupinamba_melee_states.PATROL] = s_tupinamba_melee_idle;
mask_array[tupinamba_melee_states.JUMP] = s_tupinamba_melee_idle;
mask_array[tupinamba_melee_states.HANGING] = s_tupinamba_melee_idle;
mask_array[tupinamba_melee_states.EVADE] = s_tupinamba_melee_idle;


//evade
has_evade = true;
evade_delay_initial = room_speed*0.5;
evade_delay = evade_delay_initial;
evade_chance = 2;//0.33;
//avoid one hit
function tupinamba_melee_evade(){
	
	var  _evade = random(1);

	var evade_window = false;
	//if player are attacking
	
	show_debug_message("player state: " + string(o_player.state));
	show_debug_message("player evade_window: " + string(evade_window));
	
	if has_evade {
		if instance_exists(o_player) {
			if (o_player.state == 3 or	//o_player.states_array[states.ATTACK] or
			o_player.state == 4 or		//o_player.states_array[states.ATTACK_WALK] or
			o_player.state == 5 ) {		//o_player.states_array[states.AIR_ATTACK] {
				evade_window = true;
			}
		
			if distance_to_object(o_player) < 50 and
			 o_player.hp  > 0 and 
			 o_player.facing == facing*-1 and
			 alert and  evade_window {
				
				has_evade = false;
				evade_delay = evade_delay_initial;
					
				if 	_evade < evade_chance {
					can_take_dmg = false;
					y+= -1;
					facing*= -1;
					launch( jump_vsp * 0.7 , max_hsp*7 , -1*facing );
					state = tupinamba_melee_states.EVADE;
			
					//dust
					jump_dust();
					audio_play_sound(snd_jump, 15, false, global.volume);
			
					image_index=0;
					image_speed=1;
				}
			}		
		}
	}else {
		evade_delay--
		if evade_delay < 0 {
			has_evade = true;
		}
	}	
}



function tupinamba_melee_attack() {
	
	if distance_to_object(o_player) < 50
	 and can_attack
	 and sign(o_player.x - x) == facing { //olhando pro player
		
			can_attack = false;
			attack_delay = room_speed * 5;
			state = tupinamba_melee_states.ATTACK;
			image_index =0;
			alarm[CAN_ATTACK]= attack_delay;
	} 
}

