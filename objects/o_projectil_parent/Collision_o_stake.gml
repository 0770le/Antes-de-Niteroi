
//indo para a direita 
if hsp > 0 {
	//encontro flecha vindo da esquerda para direita
	if ((xprevious < other.bbox_left) and  ( other.facing == -1)) {
		die = true;  
	}
//encontro pela direita para esquerda
} else {
	if ((xprevious > other.bbox_right) and  ( other.facing == 1)) {
		die=true;	
	}	
}
	


