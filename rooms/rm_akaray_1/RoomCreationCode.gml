
//show roo_title
call_later(3,  time_source_units_frames,function(){show_msg("Akaray", 5)});

instance_create_layer(0,0,LAYER_CONTROLLERS, o_akaray_level_controller);
instance_create_layer(0, 0, LAYER_CONTROLLERS, obj_initializer);