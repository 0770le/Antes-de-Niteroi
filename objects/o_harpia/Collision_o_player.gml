
if(state == harpia_states.ATTACK) {
	with(o_player) {
		process_enemy_attack();
	}
	unstoppable = false;
	state = harpia_states.CHASE;
	hsp = -hsp;
	dir = sign(hsp);
}
