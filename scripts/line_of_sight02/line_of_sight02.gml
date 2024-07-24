/// @function		line_of_sight()
/// @description	check if thes collision tiles between the caller and the player

function line_of_sight02() { 
// retorna true se (jogador nao esta escondido E vendo player na esquerda OU direita, sem nada na frente

	if !o_player.hidden and	(((o_player.x < x) and (facing == -1)) or ((o_player.x > x) and (facing == 1))) { 
		//lista com objetos de colisao
		var _collided = ds_list_create();
		var _num = collision_line_list(x,y, o_player.x, o_player.y, layer_tilemap_get_id("Collisions") ,false,false, _collided ,false);
		
		for (var i = 0; i < _num; i++) {
			if (_collided[| i] == SOLID) {
				return true;	
			}
		}
		
		return false; 
	}
}
