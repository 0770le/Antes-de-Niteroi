event_inherited();
//init
hsp = 0;
vsp = 0;
hsp_decimal = 0;
vsp_decimal = 0;
spd = 6;
launched = false;
init_vsp = 8;
knockback_distance = 0.1;
facing = 0;
image_speed = 0;
drag = 0.1;


on_fire=false;

fire = instance_create_depth(x,y,depth-1,o_generic_animation);
fire.sprite_index = s_arrow_flame;
fire.attached_to = id;
fire.attach_flip_rotation = true;
fire.stop_animation = false;
fire.visible = on_fire;

grav = global.grav;
follow_x = x;
follow_y = y;
follow_moment = 33/spd;// arrow_width

////rastro 
//call_later(follow_moment, time_source_units_frames, function () {	//cria o rastro
//	var inst = instance_create_depth(follow_x, follow_y-1 , depth, o_projectil_tail);
//	tail_id = inst.id;
//	with(tail_id) {
//		speed = other.spd;
//		player_arrow = true;
//		facing = other.facing;
//		image_xscale = sign(hsp);
//	} 
//});