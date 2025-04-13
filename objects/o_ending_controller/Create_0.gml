
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
"",
];