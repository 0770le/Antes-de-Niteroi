function armadeira_walk_state(){
	image_speed =1;
	
	//set mov
	hsp = spd * facing;
	
	//change state
	//idle
	if (abs(start_x - x) > patrol_dis) { 
		alarm[HIDING] = hide_delay;
		state = armadeira_states.IDLE;
	}	
	// attack 
	if alert and !on_ceeling()  {
		state = armadeira_states.ATTACK;
		
		agressive_timer = room_speed * random_range(1.5, 3);
	}

	// a wall is found	
	var t1 = tilemap_get_at_pixel(global.map, side() + sign(hsp), y);
	if (t1 == SOLID) {
		//decisão
		var _choice = choose (1,2);
		
		//voltar horizontal
		if (_choice == 3) {
			facing*=-1;
		} else {		
			//cair do teto
			if on_ceeling() { 
				facing*=-1;
				state = armadeira_states.JUMP;
				y += 1;
				launch(0,2);
			//escalar	
			} else {
				y-=1;
				state = armadeira_states.CLIMB;	
				target_x = x;
			}
		}
	}
	
	//tail
	var t1 = tilemap_get_at_pixel(global.map, side(false), bbox_top -1);
	//um na frente do ultimo e cima extra
	var t2 = tilemap_get_at_pixel(global.map, side(false)+1*facing, bbox_top -1);
	
	//achou virada pro prox andar
	if on_ceeling() {
		if t1 == SOLID and t2 != SOLID {
			//acertadinha pra ficar do lado da parede
			x += 1*facing;
			//vira pra parede
			facing *= -1;
			//acerta y pra encostar
			y -= 1;
			//mudar escalar pra começar por canto superior
			state = armadeira_states.CLIMB;
			target_x = x;
			hsp=0;
		
		}
	}
	
	//apply movement
	
	var _grav = global.grav;
	if(on_ceeling()) {
		_grav = 0;
	}
	
	calc_entity_movement(_grav);
	collision();
}
