/// @description Insert description here
// You can write your code in this editor

if(instance_exists(inst) and duration-- >= 0) {
	x = inst.x + offset_x + 5*image_xscale;
	y = inst.y + offset_y;	
} else {
	instance_destroy();
}