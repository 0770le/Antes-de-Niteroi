if(room != rm_paulo_gustavo and room != rm_studio_logo) {
	stop_ambience_sounds();
	
	if (room == rm_main_menu)
	{
		stop_all();
	}
	else 
	{
		start_ambience_sounds_with_room(room);
	}
	
	update_sound_stage(room);
}
