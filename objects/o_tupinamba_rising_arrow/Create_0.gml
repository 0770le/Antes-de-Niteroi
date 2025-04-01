event_inherited();

//init
spd = TUPINAMBA_ARROW_SPD;
v_spd = 0;
facing = 0;
image_speed = 0;
grav = global.grav*0.25;
knockback_distance = 0.1;
dir = 0;
damage = 1;


min_spd = 0;
max_spd =7.5;
 
start_speed = spd;
start_v_spd = v_spd;
start_direction = direction;

follow_x = x;
follow_y = y;
follow_moment = 33/spd;// arrow_width

global.sound_controller.update_event_parameter_and_play_pos(
	FMOD_EVENT.TUPI_ARCHER_ATTACK, 
	FMOD_PARAMETER_NAME_MOVE, 
	FMOD_PARAMETER_VALUE_TUPI_ARCHER_ATTACK.RELEASE,
	x, y
);

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