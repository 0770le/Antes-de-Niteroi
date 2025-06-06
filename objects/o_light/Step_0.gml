if (col == c_black) {
	switch(type) {
		case 0:
			//candle
			intensity = 0.4;
			radius = 26;
			col = make_color_rgb(220,130,50);
		
		break;
		
		case 1:
			//leaf hole
			intensity = 0.12;
			radius = 10;
			col = make_color_rgb(240, 240, 230);
			flickering = false;
		break;
		
		case 2:
			//chest
			intensity = 0.25;
			radius = 40;
			col = c_red;
			flickering = false;
		break;
		
		case 3:
			//water
			intensity = 0.1;
			radius = 20;
			col = c_aqua;
		break;
		
		case 4:
		//gems
		intensity= .2;
		radius = 15;
		flickering = false;
			switch(col_index) {
				case 0: col = c_lime; break;
				case 1: col = c_yellow; break;
				case 2: col = c_aqua; break;
				case 3: col = c_purple; break;
				case 4: col = c_red; break;
			}	
		break;
		
		case 5:
			//hp
			intensity = 0.3;
			radius = 18;
			col = c_white;
			flickering = false;
		break;
	
		case 6:
			//flame torch
			intensity = 0.4;
			radius = 34;
			col = make_color_rgb(250,134,59);
		break;
	
		case 7:
			//collectible
			intensity= 0.9;
			radius = 15;
			flickering = false;
			col = make_color_rgb(255,215,0);
	
		case 8:
			//window
			intensity = 0.1;
			radius = 20;
			col = make_color_rgb(220,134,59);
			flickering = false;
		break;
	}
	
	
}

