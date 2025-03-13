event_inherited();

//init
spd =  TUPINAMBA_ARROW_SPD;
v_spd = 0;
facing = 0;
image_speed = 0;
grav = global.grav*0.25;
gravity= grav;
knockback_distance = 0.1;
damage = 1;

//destroy objetc
die = false;

//calculating vertical speed
var _x_delta = abs((o_player.x + o_player.hsp * o_player.facing) - x) / spd;
var _y_delta = y - (o_player.bbox_top + (o_player.vsp/2)*_x_delta)-6;

v_spd = (_y_delta + (0.5 * grav * power(_x_delta, 2))) / _x_delta;

//faz ir na direçao do player
motion_add(90, v_spd);
motion_add(o_player.x >= x ? 0 : 180, spd);

min_spd = 0;
max_spd =7.5;
speed = clamp(speed, min_spd ,max_spd);
 
image_angle = direction ;
 
start_speed = spd;
start_v_spd = v_spd;
start_direction = direction;
	
//generate tail

tail_id = noone;
_once = false;
follow_moment = 33/spd;//arrow_width
follow_x = x;
follow_y = y;

//rastro de ambas as penas
call_later(follow_moment, time_source_units_frames, function () {	//cria o rastro
		var inst = instance_create_depth(follow_x+3*facing, follow_y-2 , depth, o_projectil_tail);
		tail_id = inst.id;
		with(tail_id) {
			
			min_spd = other.min_spd;
			max_spd = other.max_spd;
			speed = clamp(speed, min_spd , max_spd);
			direction = other.start_direction;
			//player direction
			motion_add(90,  other.start_v_spd);
			motion_add(other.x >= x ? 0 : 180,  other.start_speed);
			grav= other.grav;
		 } 
	 });

//call_later(follow_moment, time_source_units_frames, function () {	//cria o rastro
//		var inst = instance_create_depth(follow_x, follow_y-2 , depth, o_projectil_tail);
//		tail_id2 = inst.id;
//		with(tail_id2) {
			
//			min_spd = other.min_spd;
//			max_spd = other.max_spd;
//			speed = clamp(speed, min_spd , max_spd);
//			direction = other.start_direction;
//			//player direction
//			motion_add(90,  other.start_v_spd);
//			motion_add(other.x >= x ? 0 : 180,  other.start_speed);
//			grav= other.grav;
//		 } 
//	 });