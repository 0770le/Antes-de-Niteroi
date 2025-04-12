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

msgs = ["Liberte o jovem maracajas prisioneiro\nperto da praia.",
		"Navegue para Nitcheroy e destrua\no forte de Seregipe.\nRetorne caso fique perdido.",
		"Para ir para Seregipe voce precisa pegar\na balsa em Morguja Uasu, mas\nhá boatos que o barqueiro foi sequestrado.",
		"Você precisa achar o arco e flexa, encontre o barqueiro preso no forte e navegue para Reri'pe",
		"Para adentrar o forte voce precisa do manto sagerado, ele se encontra adentro da floresta em Keryi",
		"Você ja tem tudo que precisa para completar a sua missao, vá para seregipe e derrube o forte"]

text_x_scale = [7.5,7,7,7,7,7];
text_y_scale = [TEXT_Y_HEIGHT_2l,TEXT_Y_HEIGHT_3l,TEXT_Y_HEIGHT_2l,TEXT_Y_HEIGHT_2l,TEXT_Y_HEIGHT_2l,TEXT_Y_HEIGHT_2l];

quest = true;

step1_x = 1711;
step1_y = 415;
