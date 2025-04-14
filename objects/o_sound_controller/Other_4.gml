if(room != rm_paulo_gustavo and room != rm_studio_logo) {
	stop_ambience_sounds();
	
	if (room == rm_main_menu or room == rm_ending)
	{
		stop_all();
	}
	else 
	{
		start_ambience_sounds_with_room(room);
		
		if (room == rm_seregipe)
		{
			global.options_controller.set_sound_stage_parameter(
				SOUND_STAGE_SEREGIPE, 
				FMOD_PARAMETER_MUSIC_STAGE_SEREGIPE_VALUE.INTRO
			);
		} 
		if (room == rm_seregipe_exploding)
		{
			global.options_controller.set_sound_stage_parameter(
				SOUND_STAGE_SEREGIPE_2, 
				FMOD_PARAMETER_MUSIC_STAGE_SEREGIPE_2_VALUE.INTRO
			);
		}
		else if (room == rm_reri_pe) 
		{
			global.options_controller.set_sound_stage_parameter(
				SOUND_STAGE_RERIPE, 
				FMOD_PARAMETER_MUSIC_STAGE_RERIPE_VALUE.INTRO
			);
		}
	}
	
	update_sound_stage(room);
}
