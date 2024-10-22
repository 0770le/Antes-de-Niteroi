
//show roo_title
call_later(3,  time_source_units_frames,function(){show_msg("Cidade Velha", 5)});


instance_create_layer(0,0,LAYER_CONTROLLERS, o_sound_controller);
instance_create_layer(0,0,LAYER_CONTROLLERS, o_confirmation_controller);
instance_create_layer(0,0,LAYER_CONTROLLERS, o_log_registry);
instance_create_layer(0,0,LAYER_CONTROLLERS, o_biodiversidade_controller);
instance_create_layer(0,0,LAYER_CONTROLLERS, o_log_controller);
instance_create_layer(0,0,LAYER_CONTROLLERS, o_menu_controller);

//var layer_id = layer_get_id("Hostage");
//instance_deactivate_layer(layer_id);
layer_id = layer_get_id("Travel");
instance_deactivate_layer(layer_id);

//o_sound_controller.play(FMOD_EVENT.MUSIC_GAMEPLAY);

//// view_block
var _tile_size = 32;
var _columns = 1+ (room_width/ _tile_size);
var _lines = 1+ (room_height/ _tile_size);
var t1 = tilemap_get_at_pixel(layer_tilemap_get_id("Collisions"),  0  , 0 );
//objeto que tapa visao do inimigo
//fazer coluna
for (var i = 0; i < _columns; ++i) {
	//linha
	for (var j = 0; j < _lines; ++j) {
		//bloco do teste
		t1 = tilemap_get_at_pixel(layer_tilemap_get_id("Collisions"), (_tile_size * (i+1)) - _tile_size  , (_tile_size * (j+1)) - _tile_size ); 
		
		if t1 == SOLID {
			//gerar o o_view_block
			var inst = instance_create_layer ( _tile_size * i  , _tile_size * j , "View_Block", o_view_block);		
		}
	}
}		
					
				
				
	
	

