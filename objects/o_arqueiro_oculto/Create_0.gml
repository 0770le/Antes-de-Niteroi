event_inherited();

enemy_animation = arqueiro_oculto_anim;
can_take_dmg = true; 


collision_dmg = false;
// dano e velocidade no o_arrow

knockback_distance = 5;
can_fire = true;
fire_delay_initial = room_speed * 2;
fire_delay = fire_delay_initial;
//animation
attack = false;
anim_duration = room_speed *.3;
//randon start to avoic sinc enemies
anim_start_initial = room_speed * random_range( 1.75, 2.25);
anim_start = anim_start_initial;
image_speed=0;
facing = -1;

alert_distance = TILE_SIZE;
alert_cooling = 0;

//HIDING
hidden= false;
hide_delay = 0.5 * room_speed;


//arrow spawning y pos
spawn_pos =1;

//states
enum arqueiro_oculto_states {
	IDLE,
	HIDE
}

states_array[enemy_states.IDLE] = arqueiro_oculto_idle_state;
states_array[arqueiro_oculto_states.HIDE] = arqueiro_oculto_hide_state;

sprites_array[arqueiro_oculto_states.IDLE] = s_arqueiro_oculto_idle;
sprites_array[arqueiro_oculto_states.HIDE] = s_arqueiro_oculto_idle;





