with(o_player){

	//horizontal collision

	//indo para a direita 
	if (hsp > 0) {
		
		//encontro player vindo da esquerda
		if (xprevious < other.bbox_left) {
			x = xprevious;  
		}	
		
		//encontro pela direita
		}else {
		if (xprevious > other.bbox_right) {
			x = xprevious;
		}
	
		hsp=0;
	}
	
	
}
