//shoot if within player's views
if (on_screen(TILE_SIZE)) { // global.tile_size)) {
	//object is within screen
	if (can_fire) {
		can_fire = false;
		fire_delay = fire_delay_initial;
		
		//set spawn transition from the center
		var ypos = ((sprite_get_height(sprite_index) /2) -2) * spawn_pos;
		//switch position for next arrow
		spawn_pos *= -1;
		
		//create arrow
		var inst = instance_create_layer(x,y + ypos, LAYER_PROJECTILES, o_arrow);
		inst.facing = facing;
		
		//create spark
		var _side = bbox_left;
		if (facing) {
			_side = bbox_right; 
		}
		
		//sound
		audio_play_sound(snd_arrow_firing,10, false, global.volume);
		
	} else {
		fire_delay --;
		if (fire_delay <= 0) {
			can_fire = true;
		}
	}
} else { //not in the screen
	fire_delay--;
}




