vsp_initial  = random_range(-5,-2);
vsp = vsp_initial;
facing = 1;
hsp_initial = random_range(0.3, 2);
hsp = 0;
hsp_decimal = 0;
vsp_decimal = 0;
drag = 0;
grav = 0.1;
//pick one sprite
image_index = irandom(image_number -1); //começa em zero
//has bounce happened yet?
bounce = 0;
angle_speed = random_range(20,-20);
death_protection = true;