event_inherited();
//init
hsp = 0;
vsp = 0;
hsp_decimal = 0;
vsp_decimal = 0;
spd = 8;
facing = -1;
image_speed = 0;

//destroy objetc
die = false;

on_fire=false;

fire = instance_create_depth(x,y,depth-1,o_generic_animation);
fire.sprite_index = s_arrow_flame;
fire.attached_to = id;
fire.attach_flip_rotation = true;
fire.stop_animation = false;