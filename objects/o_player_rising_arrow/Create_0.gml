//init
hsp = 0;
vsp = 0;
hsp_decimal = 0;
vsp_decimal = 0;
spd = 6;
launched = false;
push_vsp = 7;
push_hsp = spd;
facing = o_player.facing;
image_speed = 0;
drag = 0.1;

//destroy objetc
die = false;

//change objects layer after a set time
alarm[LAYER_CHANGE] = room_speed/7;


