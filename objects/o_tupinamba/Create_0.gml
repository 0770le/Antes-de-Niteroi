event_inherited();

//hanging
hanging_time_initial = room_speed * 0.2;
hanging_time = hanging_time_initial;

//BOW
//arrow spawning y pos
spawn_pos =1;
ypos = -22; 
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
alert_distance = TILE_SIZE * 16;
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

die_sound_event = FMOD_EVENT.TUPI_ARCHER_DIE;
hurt_sound_event = FMOD_EVENT.TUPI_ARCHER_HURT;

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

//para o objeto tupinamba rising arrow original. (inimigo + dificil)
//function create_arrow() {
//	if (on_screen()) {
//		//set spawn position		
//			ypos = -22;
//		//create arrow
//			var inst = instance_create_layer(side()+4*facing,y + ypos, LAYER_PROJECTILES, o_tupinamba_rising_arrow);
//			inst.facing = facing;
//		//sound
//			audio_play_sound(snd_arrow_firing,10, false, global.volume);
//		//create spark
//			inst = instance_create_layer (side()+4*facing, y + ypos, LAYER_PROJECTILES, o_arrow_spark);			
//			inst.image_xscale = facing;
//	}
//}
target_data = noone;
function get_target_data() {	
	var _spd = TUPINAMBA_ARROW_SPD;
	var _x_delta = abs((o_player.x + o_player.hsp * o_player.facing) - (side()+4*facing)) / _spd; //x do tupinamba. botar x da flecha 
	var _y_delta = y + ypos - (o_player.bbox_top + (o_player.vsp/2)*_x_delta)-6;	
    var target_data = {
        spd: _spd,
        v_spd: 0,
        grav: global.grav * 0.25,
	//calculating vertical speed
		x_delta : _x_delta,
		y_delta : _y_delta,
		dir : o_player.x >= x ? 0 : 180	
    };
    target_data.v_spd = (target_data.y_delta + (0.5 * target_data.grav * power(target_data.x_delta, 2))) / target_data.x_delta;	
    return target_data;
}
// Função para criar a flecha com os dados obtidos
function create_arrow_1(target_data) {
	//create arrow
	
	var inst = instance_create_layer(side()+4*facing,y + ypos, LAYER_PROJECTILES, o_tupinamba_rising_arrow_1);
	inst.facing = facing;
	
	with(inst) {
		
		v_spd = target_data.v_spd;
		spd = target_data.spd;	
	  
		gravity = grav;
		dir = target_data.dir;
	
		
		
	    image_angle = dir;//direction;	
		//faz ir na direçao do player
		motion_add(90, v_spd);
		motion_add(dir, spd);
		speed = clamp(speed, min_spd, max_spd);

		start_speed = target_data.spd;
	    start_v_spd = target_data.v_spd;
	    start_direction = dir;// direction;
		
		//rastro de ambas as penas
			call_later(follow_moment, time_source_units_frames, function () {	//cria o rastro
			var inst = instance_create_depth(follow_x+3*facing, follow_y-2 , depth, o_projectil_tail);
			tail_id = inst.id;
			with(tail_id) {
			
				min_spd = other.min_spd;
				max_spd = other.max_spd;
				speed = clamp(speed, min_spd , max_spd);
				direction = other.start_direction;
				//player direction
				motion_add(90,  other.start_v_spd);
				motion_add(other.x >= x ? 0 : 180,  other.start_speed);
				grav= other.grav;
			 } 
		 });
		
	}
}
