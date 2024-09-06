function armadeira_jump_state(){
	hidden=false;
	if (can_attack) {
		vsp = jump_vsp;
		hsp = jump_hsp *facing;
		can_attack = false;
		attack_cd =  room_speed * random_range(3, 5); 
		alarm[CAN_ATTACK] = attack_cd; 
		if(on_screen(40)) {
			audio_play_sound(snd_frog_jump, 40, false);
		}
	}
	
	if(on_ground()) {
		hsp=0;
		state = armadeira_states.ATTACK;
	} 
	
	//apply movement
	collision();

}