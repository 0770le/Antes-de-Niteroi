/// @description Insert description here
// You can write your code in this editor

frame+=frameSpd;
if(frame > sprite_get_number(s_HUD_hp_bar_losing)-1) {
	instance_destroy();	
}