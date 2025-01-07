
//show roo_title
call_later(3,  time_source_units_frames,function(){show_msg("Cidade Velha", 5)});
create_view_block();

instance_create_layer(0,0,LAYER_CONTROLLERS, o_confirmation_controller);
instance_create_layer(0,0,LAYER_CONTROLLERS, o_log_registry);
instance_create_layer(0,0,LAYER_CONTROLLERS, o_log_disclosure);
instance_create_layer(0,0,LAYER_CONTROLLERS, o_biodiversidade_controller);
instance_create_layer(0,0,LAYER_CONTROLLERS, o_log_controller);
instance_create_layer(0,0,LAYER_CONTROLLERS, o_menu_controller);
instance_create_layer(0,0,LAYER_CONTROLLERS, o_cidade_velha_level_controller);


//o_sound_controller.play(FMOD_EVENT.MUSIC_GAMEPLAY);


