//death

	//gap in frames 
		runned_once = true;
		alarm[ONCE] = room_speed*0.2;
	//set spawn position		
		ypos = y;
	//create arrow
		var inst = instance_create_layer(side()+4*facing,y + ypos, "Arrow_shoot", o_frances_die);
		inst.facing = facing;
	//sound
		audio_play_sound(snd_arrow_firing,10, false, global.volume);
	//create hat
		var inst = instance_create_layer (x, bbox_top, "Arrow_shoot", o_drop);			
		
		inst.sprite_index = s_frances_capacete;
			
	//inst.image_xscale = facing;
	//create gun
		var inst = instance_create_layer (side()+4*facing, y - 22, "Arrow_shoot", o_drop);			
		//inst.image_xscale = facing;
		
		inst.sprite_index = s_france_arma;
		inst.bounce = 1;
		inst.facing = facing;