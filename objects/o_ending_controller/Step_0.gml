#region explosion

var _layer_id = layer_get_id(LAYER_BACKGROUND_3);
var _layer_x = layer_get_x(_layer_id);
layer_x(LAYER_BACKGROUND_3, _layer_x-0.05);

_layer_id = layer_get_id(LAYER_BACKGROUND_6);
_layer_x = layer_get_x(_layer_id);
layer_x(LAYER_BACKGROUND_6, _layer_x-0.05);


if(flash_alpha > 0) {
	flash_alpha -= 0.01;	
	emit_smoke(356,152,0.5,1,150,flash_alpha)
	
	if(flash_alpha == 0) {
		credits = true;	
	}
}

if(explosion_time < explosion_time_final) {
	explosion_time++;
} else {
	if(explode) {
		explode	 = false;
		flash_alpha = 2;
		
		var lay_id = layer_get_id(LAYER_BACKGROUND_1);

		var back_id = layer_background_get_id(lay_id);
		layer_background_sprite(back_id, s_ending1_2);
		
	}
	
	shake = max(0,shake-0.02);
	
	if(shake> 0 and global.timer mod 6 == 0) {
		camera_set_view_pos(view_camera[0], 0, 10+random(shake) - shake/2);
	}
	if(global.timer mod 6 == 0) {
		emit_smoke(356,182,0.3,1,100,1);
	}
}

if(explode and explosion_time > 2*60 and global.timer mod 4 == 0) {
	shake = map_value(explosion_time, 0, explosion_time_final, 0, 6);
	
	camera_set_view_pos(view_camera[0], 0, 10+random(shake) - shake/2);
	
	var _ammount = explosion_time/140;
	
	emit_explosion(356,152,100,_ammount)
	emit_smoke(356,152,0.5,1,150,_ammount);
}

#endregion

#region credits

if(credits and !end_credits) {
	if(credits_alpha < 0.5) {
		credits_alpha += 0.01;	
	}
	
	var _spd = keyboard_check(vk_escape)? credits_y_spd*10 : credits_y_spd;
	
	credits_y -= _spd;
	
	if(credits_y + (array_length(credits_name)*credits_y_height) + sprite_get_height(s_realizacao) < 0) {
		end_credits = true;
	}
}

if(end_credits) {
	if(credits_alpha > 0) {
		credits_alpha -= 0.01;	
	} else {
		end_credits_alpha += 0.01;
	}
}

if(end_credits_alpha > 1.5) {
	room_goto(rm_main_menu);
}

#endregion