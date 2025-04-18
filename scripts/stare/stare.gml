///desc@ olha pro player
function stare(){
	if instance_exists(o_player) {
		facing = sign(o_player.x - x);
		if(facing == 0) {
			facing = 1;	
		}
	}
}