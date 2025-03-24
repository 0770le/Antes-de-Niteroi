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


image_speed=0;
facing = -1;

alert_distance = (TILE_SIZE*2);
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





