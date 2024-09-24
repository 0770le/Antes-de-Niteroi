
if player_arrow {
	calc_entity_movement();
	hsp = hsp * facing;
	x = hsp;
	y += vsp;
	col_head = c_blue; 
	col_tail=  c_yellow; //make_colour_rgb(235,116,116);
}else {
	gravity= grav;
	speed = clamp(speed, min_spd , max_spd);
	col_head = c_red; 
	col_tail=  c_maroon; //make_colour_rgb(235,116,116);
}