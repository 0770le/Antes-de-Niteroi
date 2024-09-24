/// @function		line_of_sight()
/// @description	check if thes collision tiles between the caller and the player

function line_of_sight() { 
// retorna true se (jogador nao esta escondido E vendo player na esquerda OU direita, sem nada na frente

	if !o_player.hidden and	(((o_player.x < x) and (facing == -1)) or ((o_player.x > x) and (facing == 1))) { 
		
		var _blocked_view = collision_line(x,bbox_top, o_player.x, o_player.y - o_player.sprite_width/2, o_view_block ,false ,false);
		
		if _blocked_view == noone {
			return true;
		} 
	}
}