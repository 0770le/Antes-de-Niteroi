
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

//indo para a direita 
if (hsp > 0) {
	
	//encontro player vindo da esquerda
	if ((xprevious < other.bbox_left) and  ( other.facing == -1)) {
		x = xprevious;  
	}	
		
	//encontro pela direita
	}else {
	if ((xprevious > other.bbox_right) and  ( other.facing == 1)) {
		x = xprevious;
	}
	
	hsp=0;
}



	
	
		