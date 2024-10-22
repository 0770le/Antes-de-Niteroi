audio_play_sound(snd_pickup_gem, 5, false, global.volume);
show_msg("Novo registro adquirido: " + string(log_title),5);
	

with(o_game) {
	logs_array[logs.LOG_PARENT] = true;
}

//update light position
with(light_id) {
	instance_destroy();
}





