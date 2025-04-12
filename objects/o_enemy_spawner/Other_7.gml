image_speed = 0;
image_index = image_number-1;

if(drop_hp and !array_contains(global.options_controller.options.hp_upgrades, max_hp_location.UPGRADE_RERI_PE)) {
	with(instance_create_layer(x,y,LAYER_INSTANCES,o_max_hp)) {
		location = 	max_hp_location.UPGRADE_RERI_PE;
	}
}

if(drop_heal) {
	instance_create_layer(x,y,LAYER_INSTANCES,o_hp_full);
}