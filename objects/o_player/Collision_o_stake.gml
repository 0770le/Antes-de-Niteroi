
//apply carried over decimals
hsp += hsp_decimal;
vsp += vsp_decimal;
	
//floor decimals
//save and subtracting decimals (making sure collisions use hole numbers)
hsp_decimal = hsp - (floor(abs(hsp)) * sign(hsp));
hsp -= hsp_decimal;
vsp_decimal = vsp - (floor(abs(vsp)) * sign(vsp));
vsp -= vsp_decimal;

//horizontal collision
	var _side;
	//determine wich side to test
	if (hsp > 0) {
		_side = bbox_right;
	} else {
		_side = bbox_left;
	}

if ((other.x > x and hsp > 0) and( other.facing != facing)){
	hsp = 0;
	x = x - (x mod global.tile_size) + global.tile_size - 1 - (_side - x);
} 
if ((other.x < x and hsp < 0)and( other.facing != facing)) {
	hsp = 0;
	x = x - (x mod global.tile_size) - (_side - x);
}





	
