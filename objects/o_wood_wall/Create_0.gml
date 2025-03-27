//init variables
image_speed = 0;

hp = 3;
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
debris_number = random_range(8,12);
hurt_time = room_speed * 0.5;