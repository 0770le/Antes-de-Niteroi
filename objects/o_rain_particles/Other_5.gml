/// @description Insert description here
// You can write your code in this editor
stop();

part_emitter_destroy(particle_system, particle_emitter1);
part_emitter_destroy(particle_system, particle_emitter2);

part_type_destroy(particle_type1);
part_type_destroy(particle_type2);

part_system_destroy(particle_system);