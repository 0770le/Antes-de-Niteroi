event_inherited();

snake_gear();

snake_hide();

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
