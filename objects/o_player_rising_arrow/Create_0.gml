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

grav = global.grav;
follow_x = x;
follow_y = y;
follow_moment = 33/spd;// arrow_width

//rastro de ambas as penas
call_later(follow_moment, time_source_units_frames, function () {	//cria o rastro
	var inst = instance_create_depth(follow_x, follow_y+2 , depth, o_projectil_tail);
	tail_id = inst.id;
	with(tail_id) {
		hsp= other.spd;
		facing= other.facing;
		grav= other.grav;
		drag= other.drag;
		player_arrow = true;
	} 
});

call_later(follow_moment, time_source_units_frames, function () {	//cria o rastro
	var inst = instance_create_depth(follow_x, follow_y-3 , depth, o_projectil_tail);
	tail_id2 = inst.id;
	with(tail_id2) {
		hsp= other.spd;
		facing = other.facing;
		grav= other.grav;
		drag= other.drag;
		player_arrow = true;
	} 
});