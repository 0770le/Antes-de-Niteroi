/// @description Particles
event_inherited();

radius = 0;
ammount = 0;
duration = 0;
minSize = 0;
maxSize = 0;

//Smoke Particle
partWater = part_type_create();
//part_type_blend(partWater,true);
part_type_shape(partWater, pt_shape_pixel);
part_type_color1(partWater, make_color_rgb(99,155,255))
part_type_alpha2(partWater,0.9,0);
part_type_speed(partWater,2,3,0,0);
part_type_direction(partWater,45,135,0,0);
part_type_life(partWater,40,80);
part_type_gravity(partWater,0.08,270);


//Particle Emitter
partWater_emit = part_emitter_create(particleSystem);

