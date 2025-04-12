if(!place_meeting(x,y,o_player) and image_alpha < 1) {
	image_alpha += 0.1;	
}

if(sprite_index == s_vision_blocker_fade_down and global.player.y < y) {
	instance_destroy();	
}