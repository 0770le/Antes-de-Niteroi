
function player_die_state(){

	if (respawn_coldown > 0) 
	{
		respawn_coldown--;
	}
	else 
	{
		instance_destroy();
		
		if (lives2 > 0)
		{
			player_respawn();
		}
		else 
		{
			room_goto(rm_main_menu);
		}	
	}
	
	if(instance_exists(corpse)){
		x = corpse.x;
		y = corpse.y;
	}
}