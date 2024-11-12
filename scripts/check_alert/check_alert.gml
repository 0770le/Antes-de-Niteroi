///@desc check if  (player is in range) E (player not dead)) E (in lign of sight)))
function check_alert() {	
	//visto
	var _sight = line_of_sight();
	
	if ((((distance_to_object(o_player) < alert_distance) and (o_player.hp > 0)) and (_sight)))or hurt{
		alert = true;
		o_player.engaged = true;
		alarm[DESINGAGE] = alert_cooling;
	}
	
}