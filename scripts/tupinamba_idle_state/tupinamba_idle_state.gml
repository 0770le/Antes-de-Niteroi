
function tupinamba_idle_state() {
image_speed=1;

if(turret and line_of_sight(true,true)) {
	alert = true;
	patrol = false;	
}
	
//sees player
if alert {
	stare()
	//shoot
	if ((o_player.hp > 0) and (can_attack) and line_of_sight() and on_screen(sprite_width/3)) {
	state = tupinamba_states.SHOOT;
	can_fire = true;
	image_index=0;
	} //else {//skirmish	
	
	
} else {
//	//patrol  
	if (patrol and wait_time-- < 0)  {
		state = tupinamba_states.PATROL;
		image_index = 0;
	} 
}
	
calc_entity_movement();
//apply movement
collision();
	
}

