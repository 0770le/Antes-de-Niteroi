

explosion_time = 0
explosion_time_final = 10*60;

explode = true

shake = 0;

flash_alpha = 0;

credits = false;
credits_alpha = -3;
credits_y = room_height + 20;
credits_y_spd = 0.2;
credits_y_height = 20;

end_credits = false;
end_credits_alpha = -0.5;


instance_create_layer(0,0,LAYER_EFFECTS, o_smoke_particle);
instance_create_layer(0,0,LAYER_EFFECTS, o_explosion_particle);

camera_set_view_pos(view_camera[0], 0, 10);

global.options_controller.set_options({
		OPTIONS_LAST_ROOM: int64(rm_cidade_velha),
		OPTIONS_SPAWN_X: 1588,
		OPTIONS_SPAWN_Y: 415,
		OPTIONS_PLAYER_HP: global.game.max_hp,
		OPTIONS_PLAYER_ARROWS: global.game.max_arrows,
	});

credits_title = [
"Direção",
"",
"",
"Programação",
"",
"",
"",
"",
"Efeitos Sonoros",
"",
"",
"Música",
"",
"",
"Arte",
"",
"",
"Game Design",
"",
"",
"",
"Consultoria Histórica",
"",
"",
"Audio Engine",
"",
"",
"",
"Realização",
];

credits_name = [
"Otto Lehmann",
"",
"",
"Otto Lehmann",
"Leonardo Marques",
"Augusto Escobar",
"",
"",
"André Rente",
"",
"",
"André Rente",
"",
"",
"Leonardo Marques",
"",
"",
"Otto Lehmann",
"Leonardo Marques",
"",
"",
"Diego Nogueira Xavier",
"",
"",
"FMOD Studio",
"Firelight Technologies",
"Pty Ltd.",
"",
"",
];