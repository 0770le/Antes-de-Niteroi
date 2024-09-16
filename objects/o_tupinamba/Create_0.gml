///@desc
event_inherited();



//arrow spawning y pos
spawn_pos =1;
can_fire = true;

knockback_shoot_distance = 5;
can_fire = true;
fire_delay_initial = room_speed * 2;
fire_delay = fire_delay_initial;



//taking dmg
 
hurt = false;
hurt_time = room_speed * 0.5;
hp = 3;
can_take_dmg = true; 
flash_counter = 0;
//CASE check_enemy_hp flash dead generico
o_enemy = object_index;

//PREENCHER MANUAl
enemy_animation = tupinamba_anim;

//alert
can_alert = true;
alert = false;
alert_distance = 100;
alert_cooling = room_speed * random_range( 1.5, 3);

//movement 
spd = 1		//aceleraçao?;

hsp = 0;
max_hsp_initial = 1;
max_hsp = max_hsp_initial;
hsp_decimal = 0;
chase_spd = max_hsp_initial*1.3;

vsp = 0;
max_vsp_initial = -1;
max_vsp = max_vsp_initial;
vsp_decimal = 0;
//jump
jump_vsp = -3;
jump_hsp = 3;

facing = -1;
drag = 0.12;

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


//will he jump this chance
jump_chance = 0.5;
//how often to check for a jump chance
jump_timer_initial = random_range(1, 1.5) * room_speed;
jump_timer = jump_timer_initial;
	//CHANGE STATE -PATROL
patrol_dis = 100;
//patrol start position
start_x = x;
start_y = y;
//how long to wait before patrolling
wait_time_initial = random_range(2, 4) * room_speed;
wait_time = wait_time_initial;

//minimum distance to start chasing
chase_distance = alert_distance;	
	//HIDING
hidden= false;
hide_delay = 1.5 * room_speed;


//states
enum tupinamba_states {
	IDLE,
	TUPINAMBA_SHOOT,
}

//states
states_array[tupinamba_states.IDLE] = tupinamba_idle_state;
states_array[tupinamba_states.TUPINAMBA_SHOOT] = tupinamba_shoot_state;


sprites_array[tupinamba_states.IDLE] = s_tupinamba_idle;
sprites_array[tupinamba_states.TUPINAMBA_SHOOT] = s_tupinamba_shoot;


//function back_to_idle(){}

//function patrol(){}



function tupinamba_shoot(){
	can_fire = false;
	fire_delay = fire_delay_initial;
		
	//set spawn transition from the center
	var ypos = ((sprite_get_height(sprite_index) /2)) * spawn_pos;
	//switch position for next arrow
	spawn_pos *= -1;
		
	//create arrow
	var inst = instance_create_layer(x,y + ypos, "Arrow_shoot", o_arrow);
	inst.facing = facing;
		
	//create spark
	var inst = instance_create_layer (side(), y + ypos, "Arrow_shoot", o_arrow_spark);			
	inst.image_xscale = facing;
		
	//sound
	audio_play_sound(snd_arrow_firing,10, false);
			
}




//puff of smoke on spawn
//if (room == rm_02) {
//	alarm[SPAWN]=1;
//}

