
function arqueiro_oculto_idle_state() {
	if !can_fire {
		states = arqueiro_oculto_states.IDLE;
		image_index = 0;
	}
}