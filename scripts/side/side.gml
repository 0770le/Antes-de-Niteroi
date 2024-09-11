///@desc use facing to return lateral position
function side(_face = true){
	if _face {
		if (facing) { //direita
			return bbox_right;
		} else { //esquerda
			return bbox_left;
		}	
	} else {
			if (facing) { 
			return bbox_left;
		} else { 
			return bbox_right;
		}

	}
}