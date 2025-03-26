/// @description Insert description here
// You can write your code in this editor

if(instance_exists(attached_to)) {
	x = attached_to.x + (attach_x_off * image_xscale);
	y = attached_to.y + attach_y_off;
	if(attach_flip) {
		image_xscale = attached_to.image_xscale;
	} else if(attach_flip_rotation and attached_to.facing != facing) {
		facing = attached_to.facing;
		image_angle = 180-image_angle;
	}
} else if(attached_to != noone){
	instance_destroy();
}

if(duration > 0)
	duration--;
	
if(!destroy and duration == 0) {
	if(!fade or image_alpha == 0) {
		instance_destroy();
	} else {
		image_alpha -= 0.05;			
	}
}
