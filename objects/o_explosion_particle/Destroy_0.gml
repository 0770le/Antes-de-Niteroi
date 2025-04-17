/// @description destroy sysyem

part_emitter_destroy_all(particleSystem)
part_system_destroy(particleSystem);
part_type_destroy(partSmExp);
part_type_destroy(partSmExpDon);

global.sound_controller.stop(
	FMOD_EVENT.AMBIENCE_SEREGIPE_2_EXPLOSION_1
);
