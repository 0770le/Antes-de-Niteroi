//init variables


hp = 2;
facing = -1;
vsp_initial  = 0;
vsp = vsp_initial;
hsp_initial = 0;
hsp = hsp_initial;
hsp_decimal = 0;
vsp_decimal = 0;
drag = 0.1;
die = false;
hurt = false;
right_debris = random_range(1,3);
left_debris = random_range(1,3);
hurt_time = room_speed * 0.5;

on_fire = false;