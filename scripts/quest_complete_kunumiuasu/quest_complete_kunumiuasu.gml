// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function quest_complete_kunumiuasu(){
	instance_create_layer(3630,390,LAYER_INSTANCES,o_kunumiuasu);
	o_game.quest_saved_kunumiuasu = true;
	o_portugues.quest_step = 2;
	o_hostage.talk = false;
	o_hostage.released = true;
	o_hostage.sprite_index = s_poste_barqueiro;
}