//init
hsp = 0;
vsp = 0;
hsp_decimal = 0;
vsp_decimal = 0;
spd = 6;
v_spd = 0;
facing = 1;
image_speed = 0;
drag = 0;
grav = global.grav*0.25;
gravity= grav;
knockback_distance = 0.1;


//destroy objetc
die = false;


//change objects layer after a set time
alarm[LAYER_CHANGE] = room_speed/7;



var _x_delta = abs((o_player.x + o_player.hsp * o_player.facing) - x) / spd;
var _y_delta = y - (o_player.bbox_top + (o_player.vsp/2)*_x_delta)-6;


v_spd = (_y_delta + (0.5 * grav * power(_x_delta, 2))) / _x_delta;

//faz ir na direçao do player
motion_add(90, v_spd);
motion_add(o_player.x >= x ? 0 : 180, spd);

min_spd = 0;
max_spd =7.5;// 6.5;
speed = clamp(speed, min_spd ,max_spd);

