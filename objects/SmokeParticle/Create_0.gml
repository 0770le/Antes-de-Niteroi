/// @description Particles
event_inherited();

radius = 0;
ammount = 0;
duration = 0;
minSize = 0;
maxSize = 0;

//Smoke Particle
partSmoke = part_type_create();
//part_type_blend(partSmoke,true);
part_type_sprite(partSmoke,spr_big_smoke,0,0,1);
part_type_alpha2(partSmoke,0.15,0);
part_type_speed(partSmoke,0,0.2,0,0);
part_type_direction(partSmoke,0,359,0,0);
part_type_orientation(partSmoke,0,359,0,0,0);
part_type_life(partSmoke,80,140);
//part_type_gravity(partSmoke,0.015,180);


//Particle Emitter
partSmoke_emit = part_emitter_create(particleSystem);

