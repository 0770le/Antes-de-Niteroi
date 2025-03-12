/// @description Insert description here
// You can write your code in this editor
event_inherited();

if(o_hostage.saved and quest_step == 1 and other.interact) {
	quest_step++;
	quest_complete_kunumiuasu();
}
