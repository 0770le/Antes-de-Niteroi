/// @description Particles
event_inherited();

//Small explosion Particle
partSmExp = part_type_create();
part_type_sprite(partSmExp,spr_small_explosion,1,1,0);
part_type_life(partSmExp,20,30);
part_type_blend(partSmExp, true);
part_type_direction(partSmExp,180,180,0,0);

//Small explosion Particle
partSmExpDon = part_type_create();
part_type_sprite(partSmExpDon,spr_small_explosion_don,1,1,0);
part_type_life(partSmExpDon,20,30);
part_type_blend(partSmExpDon, true);
part_type_direction(partSmExpDon,180,180,0,0);

//Particle Emitter
partExplosion_emit = part_emitter_create(particleSystem);

