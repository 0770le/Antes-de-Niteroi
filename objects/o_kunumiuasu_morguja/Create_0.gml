event_inherited()

switch(room) {
	case rm_seregipe:
		text+= "Morguja Uasu?";
		target_rm = rm_morguja_uasu;
		target_x = 4460;
		target_y = 1246;
		break;
	case rm_morguja_uasu:
		text+= "Serigipe?";
		target_rm = rm_seregipe;
		target_x = 7040;
		target_y = 2990;
		break;
}