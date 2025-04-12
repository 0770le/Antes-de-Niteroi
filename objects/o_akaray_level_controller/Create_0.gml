/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

global.game.quest_step_portugues = max(global.game.quest_step_portugues,2);
global.options_controller.set_option(OPTIONS_QUEST_STEP_PORTUGUES, global.game.quest_step_portugues);