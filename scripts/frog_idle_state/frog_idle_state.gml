
function frog_idle_state(){
	//check health
	check_enemy_hp();
	
	//get inputs
	breathing();

	//caculate movement
	calc_entity_movement();
	
	//modify state
	//attack
	alert_distance = 40;
	alert = false; //player in front and within range, but attack is not ready
	//player in range, in facin, if can attack
	if (distance_to_object(o_player) < detect_player_dis) and (sign(o_player.x - x) == facing) {
		if (o_player.hp > 0) {
			if (can_attack) {
				//attack
				can_attack = false;
				state = frog_states.ATTACK;
				image_index=0;
				image_speed=1;
			}
		}
		alert = true;
	}
	
	if jump_timer < 0 and !alert {
		//reset timer
		jump_timer=jump_timer_initial;
		//do we jump?
		var _jump = random(1);
		if (_jump > jump_chance) {
			state = frog_states.JUMP_START;
			//reset breath values
			image_index=0;
			image_speed=1;
			max_hsp = max_hsp_initial;
			var turned = false;
			//look for solid one tile ahead
			var t1 = tilemap_get_at_pixel(global.map, x = sign(facing) * global.tile_size, bbox_bottom);
			if (t1 == SOLID) {
				facing *= -1;
				turned = true;
			}	
			//look for a void one tile ahead
			var t1 = tilemap_get_at_pixel(global.map, x = sign(facing) * global.tile_size, bbox_bottom +1);
			if (t1 == VOID) {
				if (turned == false)  {
					facing *= -1;
					//pq nao facing = true; ?
				}				
			}
			//looking for voids multiple tiles ahead
			for ( var i = 3; i > 0; i--) {
				 t1 = tilemap_get_at_pixel(global.map, x = sign(facing) * global.tile_size * i, bbox_bottom +1);
			   	if (t1 == VOID) {
					//find furthest solid jump point // tile_start_x vai ser o x onde começa o tile void
					var tile_start_x =  (x + sign(facing) * global.tile_size * i) -
										(x + sign(facing) * global.tile_size * i) mod global.tile_size;
					//mod tile_size = nao entendi, mas aqui dá o x entre origem do sapo e pixel final do solido
					
					//half of mask (pra levar a origem do sapo pro meio do solido) sprite/2 
					var half_mask = (bbox_right + 1 - bbox_left)/2;
					if (facing == 1) {
						var target = tile_start_x - half_mask;
					} else {
						var target = tile_start_x + half_mask + global.tile_size;
					}
					//adjust max_hsp to land at target
					//speed = distance/time
					//how long is frog in air = 48 ele 'sabe' precisa medir
					var steps_in_air = 48;
					max_hsp = abs(target - x)/steps_in_air;
				}
			}
		}	
	} else {
		jump_timer--;
	}
	//apply movement
	collision();
	//animations
	frog_anim();
	
}