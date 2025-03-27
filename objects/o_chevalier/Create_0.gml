event_inherited();

//allow block mechanic in collisions
can_take_dmg = false;

//taking dmg
hurt_time = room_speed * 0.5;
hp = 4; 
flash_counter = 0;
//CASE check_enemy_hp flash dead generico
o_enemy = object_index;

//anim
enemy_animation = chevalier_anim;

//alert
alert_distance =70;
alert_cooling = room_speed * random_range(3, 4);

//movement 
chase_spd = PLAYER_MAX_HSP*0.3;

//loot
hp_drop_chance = 0.3;
arrow_drop_chance = 0.3;

//actions
//attack
attack_range = 30;//nao muda a hitbox
collision_dmg = false;
damage = 1;
knockback_distance = 20;
can_attack = true;
attack_delay = room_speed *2;
//animation
attack = false;

//patrol 
patrol = true;
patrol_left_limit = x - TILE_SIZE*10;
patrol_right_limit = x + TILE_SIZE*10;
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

attack_up_delay = 0;
attack_up_cooldown = room_speed * 2;

//how long to wait before patrolling
wait_time_initial = random_range(4, 6) * room_speed;
wait_time = wait_time_initial;

//states
enum chevalier_states {
	IDLE,			//0
	HURTING,		//1
	//__
	ENGAGED,
	TURNING,
	ATTACK,
	CHASE,
	AERIAL_RIPOSTE,
	ATTACK_UP,
	BLOCKING
}

//enemy_states
states_array[enemy_states.IDLE] = chevalier_idle_state;
states_array[enemy_states.HURTING] = chevalier_hurting_state;
//chevalier_states
states_array[chevalier_states.ENGAGED] = chevalier_engaged_state;
states_array[chevalier_states.TURNING] = chevalier_turning_state;
states_array[chevalier_states.ATTACK] = chevalier_attack_state;
states_array[chevalier_states.CHASE] = chevalier_chase_state;
states_array[chevalier_states.AERIAL_RIPOSTE] = chevalier_aerial_riposte_state;
states_array[chevalier_states.ATTACK_UP] = chevalier_attack_up_state;
states_array[chevalier_states.BLOCKING] = chevalier_blocking_state;



sprites_array[chevalier_states.IDLE] = s_chevalier_idle;
sprites_array[chevalier_states.HURTING] =  s_chevalier_idle;
sprites_array[chevalier_states.ENGAGED] = s_chevalier_idle;
sprites_array[chevalier_states.TURNING] = s_chevalier_turning;
sprites_array[chevalier_states.ATTACK] = s_chevalier_attack;
sprites_array[chevalier_states.CHASE] = s_chevalier_chase;
sprites_array[chevalier_states.ATTACK_UP] = s_chevalier_attack_up;
sprites_array[chevalier_states.AERIAL_RIPOSTE] = s_chevalier_aerial_riposte;
sprites_array[chevalier_states.BLOCKING] = s_chevalier_blocking;



mask_array[chevalier_states.IDLE] = s_chevalier_idle;
mask_array[chevalier_states.HURTING] = s_chevalier_idle;
mask_array[chevalier_states.ENGAGED] = s_chevalier_idle;
mask_array[chevalier_states.TURNING] = s_chevalier_idle;
mask_array[chevalier_states.ATTACK] = s_chevalier_idle;
mask_array[chevalier_states.CHASE] = s_chevalier_idle;
mask_array[chevalier_states.AERIAL_RIPOSTE] = s_chevalier_idle;
mask_array[chevalier_states.ATTACK_UP] = s_chevalier_idle;
mask_array[chevalier_states.BLOCKING] = s_chevalier_idle;


//slowly turn to player
function turn() {
	if (instance_exists(o_player) and point_distance(x,y,o_player.x,o_player.y) < GAME_W/2) {
		//player na esquerda e olhando pra direita. OU player na direita e olhando para a esquerda
		if ((o_player.x < x and facing = 1) or (o_player.x > x and facing = -1)) {
			state = chevalier_states.TURNING;
			image_index = 0;
		} 
	} 
}

function chevalier_attack() {
		// pode atacar e já esta olhando o player.
	 if ((can_attack) and (sign(o_player.x - x) == facing)) {
			can_attack = false;
			attack_delay = room_speed * 3;
			state = chevalier_states.ATTACK;
			image_index =0;
			alarm[CAN_ATTACK]= attack_delay;
	} 
}

can_riposte = true;

function aerial_riposte() {
	//player exatamente acima do box do chavalier E com riposte   
	if ((point_distance(x,y-20,o_player.x,o_player.y-20) < 120) and sign(o_player.x - x) == facing and (o_player.y < bbox_top+20) and o_player.hp>0 and !on_ground_3(o_player) and !o_player.hurt and (can_riposte)) {
		can_riposte = false;
		state = chevalier_states.AERIAL_RIPOSTE;
		image_index =0;
		alarm[7]= room_speed/2;
		return true;
	}
	return false;
}

function attack_up() {
	if(attack_up_delay <= 0 and o_player.hp>0 and point_distance(x+(facing * 40),y-130,o_player.x,o_player.y) < 40) {
		state = chevalier_states.ATTACK_UP;
		image_index = 0;
		return true;
	}
	return false;
}
	
function blocking() {
	if (instance_exists(o_player) and (o_player.x > x and facing = 1) or (o_player.x < x and facing = -1)) {
		return true;
	}	
}

