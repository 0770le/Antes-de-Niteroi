event_inherited();

mask_index = mask_array[state];

//show_debug_message("state = " + string(state));

if state !=  tupinamba_melee_states.IDLE {
	in_idle_state = false;	
} 

tupinamba_melee_evade();
tupinamba_melee_attack();

