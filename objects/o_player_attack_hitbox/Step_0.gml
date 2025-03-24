//cycle through all enemies and see if they were hit
with (o_enemy_parent) {
	if (distance_to_object(other) < 60) {
		if (place_meeting(x,y, other)) {
			
		}	
	}
}	

//destroy arrows that are hit
var inst = instance_place(x, y, o_player_arrow); // get the id of object from the collision
if (inst != noone){ //para q só retorne em caso d collisao
	inst.die = true;
}

var inst = instance_place(x, y, o_player_rising_arrow); // get the id of object from the collision
if (inst != noone){ //para q só retorne em caso d collisao
	inst.die = true;
}




//enable death at begin step
die = true;


