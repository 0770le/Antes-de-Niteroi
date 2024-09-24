///@desc check if saw player 
function check_alert() {	
	//if (((player is in range) E (not dead)) E (in lign of sight)))
	//visto
	var sight = line_of_sight();
	
	if (((distance_to_object(o_player) < alert_distance) and (o_player.hp > 0)) and (line_of_sight())) {
		alert = true;
		o_player.engaged = true;
		alarm[DESINGAGE] = alert_cooling;
	}
	
}