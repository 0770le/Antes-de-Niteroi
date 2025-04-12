if(!on_fire) {
	with(other){
		var _text = "Se botassem fogo numa seta, isso arderia.";
		text_bubble2(id, _text, -1, 5, TEXT_Y_HEIGHT_2l);

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
}
