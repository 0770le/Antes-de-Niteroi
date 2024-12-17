

function create_view_block() {
	
	
var _columns = 1+ (room_width/ TILE_SIZE);
var _lines = 1+ (room_height/ TILE_SIZE);
var t1 = tilemap_get_at_pixel(layer_tilemap_get_id("Collisions"),  0  , 0 );
	

	
	//objeto que tapa visao do inimigo
	//fazer coluna
	for (var i = 0; i < _columns; ++i) {
		//linha
		for (var j = 0; j < _lines; ++j) {
			//bloco do teste
			t1 = tilemap_get_at_pixel(layer_tilemap_get_id("Collisions"), (TILE_SIZE * (i+1)) - TILE_SIZE  , (TILE_SIZE * (j+1)) - TILE_SIZE ); 
		
			if t1 == SOLID {
				//gerar o o_view_block
				var inst = instance_create_layer ( TILE_SIZE * i  , TILE_SIZE * j , LAYER_INSTANCES, o_view_block);		
			}
		}
	}		
}					
