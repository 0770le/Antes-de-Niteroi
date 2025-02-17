/// @description	check if there collision tiles between the caller and the player

function line_of_sight(ignore_hidden = false, ignore_facing = false) { 
// retorna true se (jogador nao esta escondido E vendo player na esquerda OU direita, sem solido na frente

	if ((ignore_hidden or !o_player.hidden) and	(ignore_facing or (sign(o_player.x - x) == facing))) { 
		
		var _blocked_view = collision_line(x,bbox_top, o_player.x, o_player.y - (o_player.bbox_bottom-o_player.bbox_top)/2, o_view_block ,false ,false);
		
		return _blocked_view == noone;
	}
	return false;
}