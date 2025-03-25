/// @description Insert description here
// You can write your code in this editor

if(instance_exists(attached_to)) {
	x = attached_to.x + (attach_x_off * image_xscale);
	y = attached_to.y + attach_y_off;
	image_xscale = attached_to.image_xscale;
}