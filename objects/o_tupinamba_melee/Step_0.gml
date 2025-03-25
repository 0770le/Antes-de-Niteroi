event_inherited();

mask_index = mask_array[state];

if (!chase_init) {
	set_chase_dis();
	chase_init = true;	
}

//show_debug_message("state = " + string(state));

if state !=  tupinamba_melee_states.IDLE {
	in_idle_state = false;	
} 

if (state !=  tupinamba_melee_states.ATTACK) {
	unstoppable = false;
}else {
	unstoppable= true;
}  

tupinamba_melee_evade();
tupinamba_melee_attack();

