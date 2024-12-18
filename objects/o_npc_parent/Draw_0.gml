/// @description Insert description here
// You can write your code in this editor

draw_self();

var _timer = 20;

if(quest and quest_draw_timer++ < _timer) {
	draw_sprite(s_quest_indicator,0,x,bbox_top - 10);	
}

if(quest_draw_timer > _timer*2)
	quest_draw_timer = 0;
	