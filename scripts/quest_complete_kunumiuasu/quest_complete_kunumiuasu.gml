// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function quest_complete_kunumiuasu(){
	instance_create_layer(3630,390,LAYER_INSTANCES,o_kunumiuasu);
	o_game.quest_saved_kunumiuasu = true;
	
	global.options_controller.set_option(OPTIONS_QUEST_SAVED_KUNUMIASU, true);

	if(global.game.quest_step_portugues <1) {
		o_portugues.quest_step = 1;
		global.game.quest_step_portugues = 1;
		global.options_controller.set_option(OPTIONS_QUEST_STEP_PORTUGUES, global.game.quest_step_portugues);
	}
	o_portugues.quest = false;
	
	o_hostage_cidade_velha.talk = false;
	o_hostage_cidade_velha.released = true;
	o_hostage_cidade_velha.saved = true;
	o_hostage_cidade_velha.sprite_index = s_poste_barqueiro;
	
	instance_destroy(o_tupinamba_melee, false);
	
	instance_create_layer(4755,373,LAYER_INSTANCES,o_collectible_kunumiuasu);
}