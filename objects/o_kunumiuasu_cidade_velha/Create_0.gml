//init variables
event_inherited()

switch(room) {
	case rm_cidade_velha:
		text+= "Akaray?";
		target_rm = rm_akaray;
		target_x = 3120;
		target_y = 830;
		break;
	case rm_akaray:
		text+= "Cidade Velha?";
		target_rm = rm_cidade_velha;
		target_x = 3720;
		target_y = 415;
		break;
}