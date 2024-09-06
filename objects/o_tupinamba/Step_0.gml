if (!instance_exists(o_fade)) {
	script_execute (states_array[state]);
	//check enemy hp
	check_enemy_hp();
	//check alert
	if (can_alert) {check_alert();}
	//calc movement
	calc_entity_movement()
	//anim
	enemy_anim();
	
	//seta a visibilidade o oposto de hidden
	//visible = !hidden;
	
	if (hidden) {
		image_alpha = lerp (image_alpha, 0.1, 0.1);
	} else {
		image_alpha = lerp (image_alpha, 1, 0.1);
	}
	
	//mantem olhando o player
	if (alert) {
		stare();
	}
	
} else {
//stop animation playing
	image_index = 0;
}



