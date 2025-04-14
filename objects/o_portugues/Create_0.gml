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

msgs = ["Araryboîa! Soltai o maracajá\nque está cativo perto da praia.",
		// depois de salvar primeiro kunu
		"Havemos de botar abaixo o forte dos franceses.\nPassai para Nheteróia e livrai os temiminós remeiros.\nSe não souberes pra onde ir, dize-me.",
		//depois de sair da primeira sala
		"Vai para a ilha de Seregipe!\nA canoa está em Morgujá-uausú.\nSe o canoeiro foi levado, procura-o noutro lugar." ,
		//depois de ir pra serigipe
		"Tens de reaver teu arco.\nAcuda ao canoeiro cativo no forte\ne dali segue para Reri'pe." ,
		//depois de pegar o arco
		"Para poderdes vencer o forte,\ncareces do manto sagrado dos tupinambás;\nele se acha mato adentro em Keryi.",
		//depois do manto
		"É agora que havemos de atacar! Retorna para\nSerigipe e bota abaixo o forte dos adversários!"]

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
