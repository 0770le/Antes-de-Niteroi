/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

alarm[0] = 1;

var _hostage_pos = irandom(4);

var _oncapos = _hostage_pos;
while (_oncapos == _hostage_pos) {
	_oncapos = irandom(4);	
}

var _x_pos = [2645,2888,2888,3016,3512]
var _y_pos = [3134,3134,3358,3358,3246]

instance_create_layer(_x_pos[_hostage_pos], _y_pos[_hostage_pos], LAYER_INSTANCES, o_hostage_seregipe);
instance_create_layer(_x_pos[_oncapos], _y_pos[_oncapos], LAYER_INSTANCES, o_iaguara);


global.game.quest_step_portugues = max(global.game.quest_step_portugues,3);
global.options_controller.set_option(OPTIONS_QUEST_STEP_PORTUGUES, global.game.quest_step_portugues);