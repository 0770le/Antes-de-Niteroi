function harpia_attack_state(){
	if(attack_prepare_timer-- <= 0) {
		unstoppable = true;
		x += hsp;
		y += vsp;
	}
	
	if(y > o_player.y or attack_hit_ground) {
		if(on_ground_2()) {
			vsp = 0;
			emit_smoke(x,bbox_bottom,0.2,0.5,10,1);
		}
		attack_hit_ground = true;
	}
	
	if(attack_hit_ground) {
		hsp = lerp(hsp, 0, 0.02);
		vsp = lerp(vsp, 0, 0.04);
		if (attack_recover_timer-- <= 0) {
			hsp = 0;
			vsp = 0;
			state = harpia_states.ATTACK_RECOVER;
			unstoppable = false;
		}
	}
}