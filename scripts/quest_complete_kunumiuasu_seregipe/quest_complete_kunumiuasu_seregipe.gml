// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function quest_complete_kunumiuasu_seregipe(){
	instance_destroy(o_hostage_seregipe,false);
	instance_create_layer(720,2990,LAYER_INSTANCES,o_kunumiuasu_seregipe);
}