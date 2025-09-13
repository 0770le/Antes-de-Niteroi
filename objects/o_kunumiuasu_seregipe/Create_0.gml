event_inherited()

switch(room) {
	case rm_seregipe:
		text+= "Reri'pê?";
		target_rm = rm_reri_pe;
		target_x = 3815;
		target_y = 1183;
		break;
	case rm_reri_pe:
		text+= "Serigipe?";
		target_rm = rm_seregipe;
		target_x = 759;
		target_y = 2991;
		break;
}