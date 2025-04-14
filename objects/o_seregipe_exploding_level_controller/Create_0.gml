/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

time = 60*60*2;
shake_ammount = 0.2;
flash = false;

instance_create_layer(0,0,LAYER_MESSAGES, o_explosion_particle);

alarm[0] = 90;