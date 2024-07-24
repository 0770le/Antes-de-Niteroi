///@desc use facing to return lateral position
function side(){

	if (facing) { //direita
		return bbox_right;
	} else { //esquerda
		return bbox_left;
	}
}