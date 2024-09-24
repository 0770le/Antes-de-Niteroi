//init
hsp = 0;
vsp = 0;
hsp_decimal = 0;
vsp_decimal = 0;
spd = 6;
launched = false;
init_vsp = 7;
knockback_distance = 0.1;
facing = 0;
image_speed = 0;
drag = 0.1;


//destroy objetc
die = false;

//change objects layer after a set time
alarm[LAYER_CHANGE] = room_speed/7;

//generate tail
grav = global.grav;
tail_id2 = noone;
tail_id = noone;
_once = false;
follow_moment = 31 /spd;//arrow_width
follow_x = x;
follow_y = y;

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