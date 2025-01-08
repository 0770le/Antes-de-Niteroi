
//horizontal collision

//indo para a direita 
if (hsp > 0) {
	
	//encontro player vindo da esquerda
	if ((xprevious < other.bbox_left) and ( other.facing == -1)) {
		x = xprevious;  
	}	
		
//encontro pela direita
} else if ( hsp <0) {
		
	if ((xprevious > other.bbox_right) and ( other.facing == 1)) {
		x = xprevious;
	}
	
}



	
	
		