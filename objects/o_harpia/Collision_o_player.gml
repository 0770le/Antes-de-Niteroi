
if(state == harpia_states.ATTACK and other.can_take_dmg) {
	with(o_player) {
		process_enemy_attack();
	}
	unstoppable = false;
	state = harpia_states.CHASE;
	hsp = -hsp;
	dir = sign(hsp);
}
