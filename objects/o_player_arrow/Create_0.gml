event_inherited();
//init
hsp = 0;
vsp = 0;
hsp_decimal = 0;
vsp_decimal = 0;
spd = 4;
facing = -1;
image_speed = 0;

//destroy objetc
die = false;

on_fire=false;

//generate tail
tail_id = noone;
_once = false;
follow_moment = 33/spd;// arrow_width
follow_x = x;
follow_y = y;

//rastro 
call_later(follow_moment, time_source_units_frames, function () {	//cria o rastro
		var inst = instance_create_depth(follow_x+3*facing, follow_y-2 , depth, o_projectil_tail);
		tail_id = inst.id;
		with(tail_id) {
			speed = other.spd;
			player_arrow = true;
			facing = other.facing;
			spd = other.spd;
			hsp = spd * facing;
			image_xscale = sign(hsp);
			//grav= other.grav;
		 } 
	 });
