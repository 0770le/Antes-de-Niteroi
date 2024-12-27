/// @description Insert description here
// You can write your code in this editor

frame = 0;
frameSpd = 0.3;
xScale = 1;

xPos = 13 + 16 + (sprite_get_width(s_HUD_hp_bar)/2)*(o_player.hp)+1;

if(o_player.hp mod 2 != 0) {
	xScale = -1;	
}
