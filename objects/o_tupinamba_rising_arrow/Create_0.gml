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

global.sound_controller.update_event_parameter_and_play_pos(
	FMOD_EVENT.TUPI_ARCHER_ATTACK, 
	FMOD_PARAMETER_NAME_MOVE, 
	FMOD_PARAMETER_VALUE_TUPI_ARCHER_ATTACK.RELEASE,
	x, y
);
