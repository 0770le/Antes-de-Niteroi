if(!place_meeting(x,y,o_wood_wall) and image_alpha > 0) {
	image_alpha -= 0.1;	
	if(image_alpha <= 0)
		instance_destroy();
}

timer++;

if(place_meeting(x,y,o_player) and timer <= 15) {
	instance_destroy();	
}