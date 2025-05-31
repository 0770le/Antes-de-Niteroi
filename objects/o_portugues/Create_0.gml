//init variables
event_inherited();

image_speed = 1;
image_index = 1;

quest_step = global.game.quest_step_portugues;

facing = 1;
vsp_initial  = 0;
vsp = vsp_initial;
hsp_initial = 0;
hsp = hsp_initial;
hsp_decimal = 0;
vsp_decimal = 0;
drag = 0.1;

runned_once= false;
target_rm = rm_cidade_velha;
target_x = 167;
target_y = 309;

msgs = ["tip-portuguese-step-0",
		// depois de salvar primeiro kunu
		"tip-portuguese-step-1",
		//depois de sair da primeira sala
		"tip-portuguese-step-2",
		//depois de ir pra serigipe
		"tip-portuguese-step-3",
		//depois de pegar o arco
		"tip-portuguese-step-4",
		//depois do manto
		"tip-portuguese-step-5"]

text_x_scale = [6.5,10.5,10,7.5,8.5,10];
text_y_scale = [TEXT_Y_HEIGHT_2l,
				TEXT_Y_HEIGHT_3l,
				TEXT_Y_HEIGHT_3l,
				TEXT_Y_HEIGHT_3l,
				TEXT_Y_HEIGHT_3l,
				TEXT_Y_HEIGHT_2l];

quest = true;

step1_x = 1711;
step1_y = 415;
