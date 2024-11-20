if (!instance_exists(o_fade)) {
	script_execute (states_array[state]);
	//check enemy hp
	check_enemy_hp();
	//check alert
	if (can_alert and !alert) {check_alert();}
		
	if instance_exists(o_player) {
		if o_player.hp <0 {alert=false;}
	}
	
	//calc movement
	calc_entity_movement()
	//anim
	enemy_anim();
	
	//not allow facing = 0;
	if image_xscale == 0 { image_xscale= 1;}
	
	
	//seta a visibilidade o oposto de hidden
	//visible = !hidden;
	if (hidden) {
		image_alpha = lerp (image_alpha, 0.2, 0.02);
	} else {
		image_alpha = lerp (image_alpha, 1, 0.1);
	}
	
	
} else {
//stop animation playing
	image_index = 0;
}



