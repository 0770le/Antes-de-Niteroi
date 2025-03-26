event_inherited();

hanging_time_initial = room_speed * 0.15;
hanging_time = hanging_time_initial;

in_idle_state = false; 
//taking dmg
hurt_time = room_speed * 0.5;
hp = 3; 
flash_counter = 0;
//CASE check_enemy_hp flash dead generico
o_enemy = object_index;

//anim
enemy_animation = tupinamba_melee_anim;

//alert
alert_distance = TILE_SIZE * 7;
alert_cooling = room_speed * random_range(5, 8);

//movement 
spd = 1;		//"aceleração";
hsp = 0;

max_hsp =  random_range(PLAYER_MAX_HSP*0.85, PLAYER_MAX_HSP*0.95 );
hsp_decimal = 0;
chase_spd = max_hsp;
vsp = 0;
vsp_decimal = 0;
//jump
jump_vsp = PLAYER_JUMP_SPEED;
jump_hsp = 4;

//loot
hp_drop_chance = 0.3;
arrow_drop_chance = 0.3;

//actions
//attack
attack_range = 40;//nao muda a hitbox
collision_dmg = false;
damage = 1;
knockback_distance = 10;
can_attack = true;
attack_delay = room_speed;
//animation
attack = false;


//patrol 
patrol = true;
patrol_left_limit = x - TILE_SIZE;
patrol_right_limit = x + TILE_SIZE;
patrol_destination = choose(-1,1);
//how long to wait before patrolling
wait_time_initial = random_range(2, 4) * room_speed;
wait_time = wait_time_initial;
	
//CHASE
//chase start position
start_x = x;
start_y = y;

//target to move to
target_x = 0;
target_y = 0;

//how long to wait before patrolling
wait_time_initial = random_range(6, 9) * room_speed;
wait_time = wait_time_initial;

//states
enum tupinamba_melee_states {
	IDLE,			//0
	HURTING,		//1
	ATTACK,			//2
	PATROL,
	JUMP,
	HANGING,
	EVADE,
	CHASE
}

die_sound_event = FMOD_EVENT.TUPI_MELEE_DIE;
hurt_sound_event = FMOD_EVENT.TUPI_MELEE_HURT;

//enemy_states
states_array[enemy_states.IDLE] = tupinamba_melee_idle_state;
states_array[enemy_states.HURTING] = tupinamba_melee_hurting_state;
//tupinamba_melee_states
states_array[tupinamba_melee_states.ATTACK] = tupinamba_melee_attack_state;
states_array[tupinamba_melee_states.PATROL] =tupinamba_melee_patrol_state;
states_array[tupinamba_melee_states.JUMP] = tupinamba_melee_jump_state;
states_array[tupinamba_melee_states.HANGING] = tupinamba_melee_hanging_state;
states_array[tupinamba_melee_states.EVADE] = tupinamba_melee_evade_state;
states_array[tupinamba_melee_states.CHASE] = tupinamba_melee_chase_state;


sprites_array[tupinamba_melee_states.IDLE] = s_tupinamba_melee_idle;
sprites_array[tupinamba_melee_states.HURTING] =  s_tupinamba_melee_hurt;
//
sprites_array[tupinamba_melee_states.ATTACK] = s_tupinamba_melee_attack;
sprites_array[tupinamba_melee_states.PATROL] = s_tupinamba_melee_walk;
sprites_array[tupinamba_melee_states.JUMP] =  s_tupinamba_melee_jump;
sprites_array[tupinamba_melee_states.HANGING] =  s_tupinamba_melee_hanging;
sprites_array[tupinamba_melee_states.EVADE] = s_tupinamba_melee_evade;
sprites_array[tupinamba_melee_states.CHASE] = s_tupinamba_melee_walk;


mask_array[tupinamba_melee_states.IDLE] = s_tupinamba_melee_idle;
mask_array[tupinamba_melee_states.HURTING] = s_tupinamba_melee_idle;
//
mask_array[tupinamba_melee_states.ATTACK] = s_tupinamba_melee_idle;
mask_array[tupinamba_melee_states.PATROL] = s_tupinamba_melee_idle;
mask_array[tupinamba_melee_states.JUMP] = s_tupinamba_melee_idle;
mask_array[tupinamba_melee_states.HANGING] = s_tupinamba_melee_idle;
mask_array[tupinamba_melee_states.EVADE] = s_tupinamba_melee_idle;
mask_array[tupinamba_melee_states.CHASE] = s_tupinamba_melee_idle;



//evade
has_evade = true;
evade_delay_initial = room_speed*2;
evade_delay = evade_delay_initial
evade_chance = 0.5;

function tupinamba_melee_evaded() {
	
	can_take_dmg = false;
	y+= -1;
	facing*= -1;
	launch( jump_vsp * 0.5 , max_hsp*3.5 , -1*facing );
	state = tupinamba_melee_states.EVADE;
	image_index=0;
	image_speed=1;		
	//dust
	jump_dust();
	audio_play_sound(snd_jump, 15, false, global.volume)		
	
}


//avoid one hit
function tupinamba_melee_evade(){
	
	var  _evade = random(1);	
	var evade_window = false;
	
	//if player are attacking
	if has_evade {
		if instance_exists(o_player) {
			if (o_player.state == 3 or	//o_player.states_array[states.ATTACK] or
			o_player.state == 4 or		//o_player.states_array[states.ATTACK_WALK] or
			o_player.state == 5 ) {		//o_player.states_array[states.AIR_ATTACK] {
				evade_window = true;
			}
		
			if (distance_to_object(o_player) < 60) and //perto do player
			 (o_player.hp  > 0) and				//player vivo
			 (o_player.facing == facing*-1) and //olhando player
			 alert and  evade_window {		//alerta e player atacando
			 
			 //chance
				if (_evade < evade_chance) {			
					tupinamba_melee_evaded();		
				} 				
				
				has_evade = false;			
				evade_delay = evade_delay_initial;
			 }
		}
	}else { //sem evade
		evade_delay--
		if on_ground() {
			can_take_dmg = true;
		}
		if evade_delay < 0 {
			has_evade = true;
		}
	}	
}



function tupinamba_melee_attack() {
	if distance_to_object(o_player) < attack_range //no alcance
	 and alert
	 and can_attack						//pode atacar
	 and sign(o_player.x - x) == facing  {//olhando pro player
	
		can_attack = false;
		attack_delay = room_speed * 3;
		state = tupinamba_melee_states.ATTACK;
		o_sound_controller.update_event_parameter_and_play_pos(FMOD_EVENT.TUPI_MELEE_ATK,FMOD_PARAMETER_NAME_MOVE,FMOD_PARAMETER_MOVE_VALUE_TUPI_MELEE_ATK.PREPARE,x,y);
		image_index =0;
		alarm[CAN_ATTACK]= attack_delay;
	} 
}

has_descend = true; //if it will try to
can_descend = true;//due cd
descend_cd = 1*room_speed;

function tupi_descend() {
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

//used in in creation os the instance in the room. Wil set chase var after you give the patrol
function set_chase(_chase_left_limit = patrol_left_limit, _chase_right_limit = patrol_right_limit){
	chase_left_limit = _chase_left_limit;
	chase_right_limit = _chase_right_limit;
}
//
call_later(2,time_source_units_frames,function(){if(patrol){set_chase();}},false);