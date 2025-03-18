/// @description Insert description here
// You can write your code in this editor

draw_self();

if(quest) {
	draw_sprite(s_quest_indicator,0,x,bbox_top - 10);	
}

show_interact_key_and_clear(self);