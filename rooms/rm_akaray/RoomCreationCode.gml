
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
create_view_block();