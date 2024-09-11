instance_create_layer(0,0,LAYER_CONTROLLERS, o_confirmation_controller);
instance_create_layer(0,0,LAYER_CONTROLLERS, o_log_registry);
instance_create_layer(0,0,LAYER_CONTROLLERS, o_biodiversidade_controller);
instance_create_layer(0,0,LAYER_CONTROLLERS, o_log_controller);
instance_create_layer(0,0,LAYER_CONTROLLERS, o_menu_controller);


// view_block
var _tile_size = 32;

var _columns = 1+ (room_width/ _tile_size);
var _lines = 1+ (room_height/ _tile_size);
var t1 = tilemap_get_at_pixel(layer_tilemap_get_id("Collisions"),  0  , 0 );
	

//fazer coluna
for (var i = 0; i < _columns; ++i) {
	//linha
	for (var j = 0; j < _lines; ++j) {
		//bloco do teste
		t1 = tilemap_get_at_pixel(layer_tilemap_get_id("Collisions"), (_tile_size * (i+1)) - _tile_size  , (_tile_size * (j+1)) - _tile_size ); 
		
		if t1 == SOLID {
			//gerar o o_view_block
			var inst = instance_create_layer ( _tile_size * i  , _tile_size * j , "View_Block", Object47);		
		}
	}
}		
					
				
				
	
	

