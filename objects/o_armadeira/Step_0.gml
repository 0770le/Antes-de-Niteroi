event_inherited();

//manter trajetoria no ar

//armadeira percebe o player sempre
if ((distance_to_object(o_player) < alert_distance) and (o_player.hp > 0)) and !o_player.hidden and on_ground() {
	stare();	
}



show_debug_message("state = " + string(state));	