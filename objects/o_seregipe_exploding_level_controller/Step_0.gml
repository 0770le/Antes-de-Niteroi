/// @description move BG

var _cam_x = camera_get_view_x(view_camera[0]);
var _cam_y = camera_get_view_y(view_camera[0]);

layer_x(LAYER_BACKGROUND_5, _cam_x * 0.8);
layer_y(LAYER_BACKGROUND_5, (_cam_y * 0.8)+250);

layer_x(LAYER_BACKGROUND_6, _cam_x * 0.9);
layer_y(LAYER_BACKGROUND_6, (_cam_y * 0.9)+50);

layer_y(LAYER_BACKGROUND_7, (_cam_y * 0.8)-50);

if(point_distance(1560,900,global.player.x,global.player.y) < 500  and irandom(4) <= 1) {
	emit_explosion(1560,900, 200, 5);	
}

if(time > 0) {
	time--;
} else {
	if(global.player.hp > 0 and global.timer mod 30 == 0 and irandom(5) <= 1) {
		global.player.hp--;
				
		//set hurt timer
		global.player.alarm[ALARM_HURTING] = global.player.hurt_time;	
		
		//change state
		global.player.state = states.HURTING;
		global.player.image_index = 0;
			
		o_sound_controller.update_position_and_play(FMOD_EVENT.HURT, global.player.x, global.player.y);
			
		with(instance_create_layer(global.player.x, global.player.y - 30, LAYER_CONTROLLERS, o_generic_animation)){
			destroy = true;
			sprite_index = spr_medium_explosion;
			flash = true;
		}
	}	
}






if(global.timer mod 300 == 0 ){
	shake_ammount += 0.1;	
}

var _chance = max(2, time/300);

if(global.timer mod 5 == 0 and irandom(_chance) <= 1) {
	scr_screen_shake(0.5,shake_ammount);
	if(time <= 0) {
			
		emit_explosion(global.player.x, global.player.y, 400, 30);	
		emit_smoke(global.player.x, global.player.y, 0.5, 1, 300, 10);
		
	}
	if(time <= 600) {
			
		emit_explosion(global.player.x, global.player.y, 400, 5);	
	}
}