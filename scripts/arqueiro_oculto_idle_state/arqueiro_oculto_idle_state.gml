
function arqueiro_oculto_idle_state() {
	stare();
	//player na frente
	if( (bbox_top < o_player.bbox_bottom)  and (bbox_bottom > o_player.bbox_top)) {
		if (can_fire) {
			can_fire = false;
			fire_delay = fire_delay_initial;
		
			//set spawn transition from the center
			var ypos = ((sprite_get_height(sprite_index) /2) - TILE_SIZE/2) * spawn_pos;
			//switch position for next arrow
			spawn_pos *= -1;
		
			//create arrow
			var inst = instance_create_layer(x,y + ypos, "Arrow_shoot", o_arrow);
			inst.facing = facing;
		
			//create spark
			var inst = instance_create_layer (side(), y + ypos, "Arrow_shoot", o_arrow_spark);			
			inst.image_xscale = facing;
			
			if (image_index == 0 or image_index == 1){
				image_index = 2;			
			} else {
				image_index = 1;
			}
		
			//sound
			audio_play_sound(snd_arrow_firing,10, false, global.volume);
		
		} 
		else {
			fire_delay --;
			
			if (fire_delay <= 0) {
				can_fire = true;
			}
		} 
		//check state
	} else { //not in range
			fire_delay--;
			state = arqueiro_oculto_states.HIDE;
	}
	
	
	if (distance_to_object(o_player) < alert_distance) {
			state = arqueiro_oculto_states.HIDE;
	} 
}