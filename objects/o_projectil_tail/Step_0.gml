
if player_arrow {
	//image_xscale = sign(hsp);
	//x += speed;//* facing;
	col_head = c_blue; 
	col_tail=  c_yellow; //make_colour_rgb(235,116,116);
	

	
}else {
	gravity= grav;
	speed = clamp(speed, min_spd , max_spd);
	col_head = c_red; 
	col_tail=  c_maroon; //make_colour_rgb(235,116,116);
}

var _arr = instance_nearest(x,y,o_projectil_parent);

if(_arr == noone or point_distance(x,y,_arr.x,_arr.y) > 100) {
	instance_destroy();	
}