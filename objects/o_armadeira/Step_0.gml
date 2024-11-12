event_inherited();



//armadeira percebe o player sempre

if (((distance_to_object(o_player) < alert_distance) and (o_player.hp > 0)) and !o_player.hidden) and on_ground()  {
	var _blocked_view = collision_line(x,y-1, o_player.x, o_player.y-1, layer_tilemap_get_id("View_Block") ,false ,false);
	 if  _blocked_view == noone{
		stare();

	 }
}


//mantem olhando o player
if alert and on_ground()  {
	stare();
}


//hide
if (state != armadeira_states.IDLE) {hidden = false;}	

//controle de teto
if !on_ceeling() {
	image_yscale = 1;
		can_alert = true;

	//no teto
	} else {
		vsp = 0;
		image_yscale = -1;
		can_alert = false;	
	
	
	//player abaixo E player perto //corrigindo diferença de origem* no y
	if o_player.bbox_top > y  and (abs(o_player.x - x) <= 30) and o_player.hp > 0 and on_screen() and line_of_sight() {
	//cair nele
		state = armadeira_states.JUMP;
		y += 1;
	}
}

	//var t1 = tilemap_get_at_pixel(global.map, side(), bbox_top);
	//var t2 = tilemap_get_at_pixel(global.map, side(false), bbox_top);
	
	////soltar do teto 
	//if  (t1 == SOLID or t2 == SOLID) {
	//	y += 1;
	//}	

