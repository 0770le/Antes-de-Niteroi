event_inherited();

//se move rapido perto do player
if ((distance_to_object(o_player) < alert_distance) and (o_player.hp > 0)) and !o_player.hidden {
	//speed up
	gear_spd = spd_array[jararaca_spds.TOP];
	//speed cooler
	wait_time = room_speed * random_range(0,0.5);
	
	//se tiver em idle e sem pode mover nao faz o som 
	if (state != jararaca_states.IDLE or can_attack) and can_zoomie { 
		//intervalo
		can_zoomie = false;
		alarm[8] = room_speed* 4;
		audio_play_sound(snd_bug_sees_player, 40, false, global.volume);
	}
} 


//hide
if (distance_to_object(o_player) < alert_distance * 6) {
	//player para de ver se estiver longe
	hidden = false;
} else {
	hidden=true;
}

//change directions
if (alarm[10] < 0){
	alarm[10] = room_speed *random_range(8 , 16);
}


//tongue
if (alarm[11] < 0) {
	tongue=true;
	licking=true;
	//time licking
	alarm[9] = room_speed * random_range(1, 1.1);
	//time between licking
	alarm[11] = room_speed * random_range(1,5);
}
