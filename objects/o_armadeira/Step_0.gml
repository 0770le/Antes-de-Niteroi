event_inherited();
//armadeira percebe o player sempre
if ((distance_to_object(o_player) < alert_distance) and (o_player.hp > 0)) and !o_player.hidden {
	stare();	
}



