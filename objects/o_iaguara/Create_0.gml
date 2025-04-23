event_inherited();

unstoppable = true;
knockback_multiplier = 0;

arrow_knockback = false;

//taking dmg
hurt_time = room_speed * 0.5;
hp = 12; 
flash_counter = 0;
//CASE check_enemy_hp flash dead generico
o_enemy = object_index;

//anim
enemy_animation = iaguara_anim;

//alert
alert_distance = TILE_SIZE * 7;
alert_cooling = room_speed * random_range(6, 8);

//movement 
spd = 6;		
hsp = 0;

acc = 0.08;
max_hsp =  PLAYER_MAX_HSP*2;
hsp_decimal = 0;
chase_spd = max_hsp;
vsp = 0;
vsp_decimal = 0;
drag =0;
hsp_override = 0;

number = 0;


//pounce


//loot
hp_drop_chance = 0.3;
arrow_drop_chance = 0.3;

//actions



//patrol 
patrol = true;
patrol_left_limit = x - TILE_SIZE * 6;
patrol_right_limit = x + TILE_SIZE * 6;
patrol_destination = choose(-1,1);
//how long to wait before patrolling
wait_time_initial = random_range(2, 4) * room_speed;
wait_time = wait_time_initial;
	
//CHASE
//chase start position
start_x = x;
start_y = y;
//minimum distance to start chasing
chase_distance = alert_distance;	
//target to move to
target_x = 0;
target_y = 0;

cliff_first_jump = false;

die_sound_event = FMOD_EVENT.OUNCE_DIE;
hurt_sound_event = FMOD_EVENT.OUNCE_HURT;

//states
enum iaguara_states {
	IDLE,			//0
	HURTING,		//1
	CHASE,			//2
	FALL,			//3
	LANDING,		//4
	ATTACK,			//5
	JUMP,			//6
	HANGING,		//7
	SLEEP,			//8
	LEAP_CLIFF
}

//enemy_states
states_array[enemy_states.IDLE] = iaguara_idle_state;
states_array[enemy_states.HURTING] = iaguara_hurting_state;
//iaguara_states
states_array[iaguara_states.CHASE] = iaguara_chase_state;
states_array[iaguara_states.FALL] = iaguara_fall_state;
states_array[iaguara_states.LANDING] = iaguara_landing_state;
states_array[iaguara_states.ATTACK] = iaguara_attack_state;
states_array[iaguara_states.JUMP] = iaguara_jump_state;
states_array[iaguara_states.HANGING] = iaguara_hanging_state;
states_array[iaguara_states.SLEEP] = iaguara_sleep_state;
states_array[iaguara_states.LEAP_CLIFF] = iaguara_leap_cliff_state;

sprites_array[iaguara_states.IDLE] = s_iaguara_idle;
sprites_array[iaguara_states.HURTING] =  s_iaguara_idle;
sprites_array[iaguara_states.CHASE] =  s_iaguara_run;
sprites_array[iaguara_states.FALL] =  s_iaguara_fall;
sprites_array[iaguara_states.LANDING] =  s_iaguara_landing;
sprites_array[iaguara_states.ATTACK] =  s_iaguara_attack;
sprites_array[iaguara_states.JUMP] =  s_iaguara_lunge;
sprites_array[iaguara_states.HANGING] =  s_iaguara_hanging;
sprites_array[iaguara_states.SLEEP] = s_iaguara_sleep;
sprites_array[iaguara_states.LEAP_CLIFF] = s_iaguara_leap_cliff;
//


mask_array[iaguara_states.IDLE] = s_iaguara_idle;
mask_array[iaguara_states.HURTING] = s_iaguara_idle;
mask_array[iaguara_states.CHASE] = s_iaguara_idle;
mask_array[iaguara_states.FALL] = s_iaguara_idle;
mask_array[iaguara_states.LANDING] = s_iaguara_idle;
mask_array[iaguara_states.ATTACK] = s_iaguara_idle;
mask_array[iaguara_states.JUMP] = s_iaguara_idle;
mask_array[iaguara_states.HANGING] =  s_iaguara_hanging;
mask_array[iaguara_states.SLEEP] = s_iaguara_idle;
mask_array[iaguara_states.LEAP_CLIFF] = s_iaguara_idle;
//

state = iaguara_states.SLEEP;
can_descend = true;
descend_cd = 1*room_speed;

function descend() {
	if (!can_descend and alarm[7] = -1 and on_ground()){ 
		can_descend = true; //poderia ser no landing state
	} 
	
	if (instance_exists(o_player) and can_descend and alert) {
		if (o_player.y > y ) {
			var t1 = tilemap_get_at_pixel(global.map, side(), bbox_bottom +1);
			if (t1 == PLATAFORM) {
				can_descend = false;
				alarm[7] = descend_cd;
			}
		}
	}	
}

//attack
attack_range = 80;
collision_dmg = true;
damage = 2;
knockback_distance = 17;
can_attack = true;
attack_delay = room_speed *6;
//animation
attack = false;

function iaguara_attack() {
	if ((abs(x - o_player.x) <= attack_range) //no alcance
	 and alert
	 and can_attack						//pode atacar
	 and (sign(o_player.x - x) == sign(facing))  //olhando pro player
	 and (y >= o_player.y)) { // abaixo ou na altura do player
			can_attack = false;
			state = iaguara_states.ATTACK;
			image_index =0;
			attack_delay = random_range(4,6) * room_speed;
			alarm[CAN_ATTACK]= attack_delay;
	} 
}

//function iaguara_pounce(jump_y, jump_x) {
//	var jump_y =0;
//	var jump_x =0;
	
//	if (o_player.y < bbox_top) {
//		jump_y = 7;	
//		jump_x= 4.5;
//	} else {
//		jump_y = 4.5;
//		jump_x = 7;
//	}
		
//	launch(jump_y, jump_x);	
//}

function play_state_update_sounds(_previous_state, _new_state) {
	
	// on enter
	switch (_new_state)
	{
		case iaguara_states.ATTACK: 
			global.deaf_assistant.show_captions_pos("Onça ataca", x);
			global.sound_controller.update_position_and_play(
				FMOD_EVENT.OUNCE_ATTACK,
				x, y
			);
			break;
	}
}
