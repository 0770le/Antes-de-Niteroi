
//show roo_title
call_later(3,  time_source_units_frames,function(){show_msg("Cidade Velha", 5)});

instance_create_layer(0,0,LAYER_CONTROLLERS, o_cidade_velha_level_controller);

create_view_block();
