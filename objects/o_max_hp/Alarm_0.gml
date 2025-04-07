/// @description Insert description here
// You can write your code in this editor


if(array_contains(global.options_controller.options.hp_upgrades, location)) {
	instance_destroy(id, false);
	instance_destroy(light_id);
}