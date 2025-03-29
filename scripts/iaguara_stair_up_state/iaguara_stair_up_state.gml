// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function iaguara_stair_up_state(){
	
	//calculate target movement
	image_speed = 1;
	target_x = o_player.xprevious;
	target_y = o_player.yprevious;
	if(	abs(x - o_player.x) > 10) {
		stare();
	}
	
	//calculate movement
	var _dir = point_direction(x, y, target_x, target_y);
	
	hsp = clamp(hsp + (facing*acc), -max_hsp, max_hsp);
	vsp = abs(hsp)*-1;

	//if knock back, don´t advance
	if ((!hurt) and (alarm[KNOCKEDBACK] < 0 )) {
		if ((abs(x - target_x) <= attack_range) and  o_player.hp > 0){
				iaguara_attack();
		}
	}
	
	
	var face = tilemap_get_at_pixel(global.map, side()+hsp, y);
	var _step_up = tilemap_get_at_pixel(global.map, side()+hsp, y- TILE_SIZE-1);
		

	if (face == SOLID){////up
		if (_step_up != SOLID) {//low
			state = iaguara_states.LEAP_CLIFF;
	
				
		}	
	}

	calc_entity_movement(global.grav, 0);
	collision(false);
}