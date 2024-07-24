//@desc copoia de o_enemy_parent

event_inherited();


//PREENCHER MANUAl

enemy_animation= intern_anim;	//inimigo_anim;


//states
enum intern_states {
	IDLE	= 0,
	ALERTED	= 1
}

states_array[intern_states.IDLE] = intern_idle_state;
states_array[intern_states.ALERTED] = intern_alerted_state;

sprites_array[intern_states.IDLE] = s_intern_idle;
sprites_array[intern_states.ALERTED] = s_intern_alerted;


